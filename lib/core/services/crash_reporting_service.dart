import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophy/core/error/models/crash_report_model.dart';
import 'package:sophy/core/services/settings_service.dart';

class CrashReportingService {
  static final CrashReportingService _instance = CrashReportingService._internal();

  factory CrashReportingService() {
    return _instance;
  }

  CrashReportingService._internal();

  final Dio _dio = Dio();
  final String _reportApiUrl = dotenv.env['CRASH_REPORT_API_URL'] ?? 'https://api.yourdomain.com/v1/crash-reports';
  static const String _offlineQueueKey = 'crash_report_queue';

  PackageInfo? _packageInfo;
  BaseDeviceInfo? _deviceInfo;
  
  bool get _isRelease => kReleaseMode;

  Future<void> init() async {
    if (!_isRelease) return; // Only active in release mode

    await _loadDeviceInfo();
    await _sendQueuedReports();
    
    // Listen to connectivity changes to retry sending
    Connectivity().onConnectivityChanged.listen((result) {
      if (!result.contains(ConnectivityResult.none)) {
        _sendQueuedReports();
      }
    });
  }

  Future<void> _loadDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    final deviceInfoPlugin = DeviceInfoPlugin();
    
    if (Platform.isAndroid) {
      _deviceInfo = await deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      _deviceInfo = await deviceInfoPlugin.iosInfo;
    } else if (Platform.isWindows) {
      _deviceInfo = await deviceInfoPlugin.windowsInfo;
    }
  }

  Future<void> reportError(dynamic error, StackTrace? stackTrace, {Map<String, dynamic>? customData}) async {
    if (!_isRelease) {
      debugPrint('CrashReporting: Error caught (Debug Mode): $error');
      return;
    }

    if (!SettingsService().isCrashReportingEnabled) {
      return; // User disabled crash reporting
    }

    try {
      final report = await _createReport(error, stackTrace, customData);
      await _sendReport(report);
    } catch (e) {
      debugPrint('CrashReporting: Failed to process error: $e');
    }
  }

  Future<CrashReportModel> _createReport(dynamic error, StackTrace? stackTrace, Map<String, dynamic>? customData) async {
    String deviceModel = 'Unknown';
    String deviceOs = 'Unknown';
    String deviceId = 'Unknown';

    if (_deviceInfo != null) {
      if (_deviceInfo is AndroidDeviceInfo) {
        final androidInfo = _deviceInfo as AndroidDeviceInfo;
        deviceModel = '${androidInfo.manufacturer} ${androidInfo.model}';
        deviceOs = 'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
        deviceId = androidInfo.id;
      } else if (_deviceInfo is IosDeviceInfo) {
        final iosInfo = _deviceInfo as IosDeviceInfo;
        deviceModel = iosInfo.utsname.machine;
        deviceOs = '${iosInfo.systemName} ${iosInfo.systemVersion}';
        deviceId = iosInfo.identifierForVendor ?? 'Unknown';
      } else if (_deviceInfo is WindowsDeviceInfo) {
        final windowsInfo = _deviceInfo as WindowsDeviceInfo;
        deviceModel = windowsInfo.productName;
        deviceOs = 'Windows ${windowsInfo.buildNumber}';
        deviceId = windowsInfo.deviceId;
      }
    }

    // Filter PII from error and stacktrace
    final cleanError = _filterPII(error.toString());
    final cleanStack = _filterPII(stackTrace?.toString() ?? '');

    return CrashReportModel(
      error: cleanError,
      stackTrace: cleanStack,
      appVersion: _packageInfo?.version ?? 'Unknown',
      buildNumber: _packageInfo?.buildNumber ?? 'Unknown',
      deviceModel: deviceModel,
      deviceOs: deviceOs,
      deviceId: deviceId, // Consider hashing this if strictly privacy focused
      timestamp: DateTime.now(),
      customData: customData,
    );
  }

  String _filterPII(String input) {
    // Basic regex to mask emails
    final emailRegex = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
    var result = input.replaceAll(emailRegex, '[EMAIL_REDACTED]');
    
    // Basic regex to mask phone numbers (generic)
    final phoneRegex = RegExp(r'\b\d{10,}\b'); 
    result = result.replaceAll(phoneRegex, '[PHONE_REDACTED]');

    return result;
  }

  Future<void> _sendReport(CrashReportModel report) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      await _queueReport(report);
      return;
    }

    try {
      // In a real app, you would use a real endpoint.
      // For this implementation, we'll simulate a successful send if the URL is dummy.
      if (_reportApiUrl.contains('yourdomain.com')) {
         debugPrint('CrashReporting: Simulated report sent to $_reportApiUrl');
         debugPrint('CrashReporting: Report content: ${jsonEncode(report.toJson())}');
         return;
      }

      await _dio.post(
        _reportApiUrl,
        data: report.toJson(),
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } catch (e) {
      // If upload fails, queue it
      await _queueReport(report);
    }
  }

  Future<void> _queueReport(CrashReportModel report) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> queue = prefs.getStringList(_offlineQueueKey) ?? [];
    
    queue.add(jsonEncode(report.toJson()));
    await prefs.setStringList(_offlineQueueKey, queue);
  }

  Future<void> _sendQueuedReports() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> queue = prefs.getStringList(_offlineQueueKey) ?? [];
    
    if (queue.isEmpty) return;

    final List<String> remainingQueue = [];

    for (final reportJson in queue) {
      try {
        final reportMap = jsonDecode(reportJson);
        // Try to send again
         await _dio.post(
          _reportApiUrl,
          data: reportMap,
           options: Options(
             sendTimeout: const Duration(seconds: 10),
             receiveTimeout: const Duration(seconds: 10),
           ),
        );
      } catch (e) {
        // Keep in queue if still failing
        remainingQueue.add(reportJson);
      }
    }

    await prefs.setStringList(_offlineQueueKey, remainingQueue);
  }
}
