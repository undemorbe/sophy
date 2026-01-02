class CrashReportModel {
  final String error;
  final String stackTrace;
  final String appVersion;
  final String buildNumber;
  final String deviceModel;
  final String deviceOs;
  final String deviceId;
  final DateTime timestamp;
  final Map<String, dynamic>? customData;

  CrashReportModel({
    required this.error,
    required this.stackTrace,
    required this.appVersion,
    required this.buildNumber,
    required this.deviceModel,
    required this.deviceOs,
    required this.deviceId,
    required this.timestamp,
    this.customData,
  });

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'stackTrace': stackTrace,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'deviceModel': deviceModel,
      'deviceOs': deviceOs,
      'deviceId': deviceId,
      'timestamp': timestamp.toIso8601String(),
      'customData': customData,
    };
  }

  factory CrashReportModel.fromJson(Map<String, dynamic> json) {
    return CrashReportModel(
      error: json['error'] as String,
      stackTrace: json['stackTrace'] as String,
      appVersion: json['appVersion'] as String,
      buildNumber: json['buildNumber'] as String,
      deviceModel: json['deviceModel'] as String,
      deviceOs: json['deviceOs'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      customData: json['customData'] as Map<String, dynamic>?,
    );
  }
}
