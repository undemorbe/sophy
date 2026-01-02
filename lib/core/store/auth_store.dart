import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sophy/core/services/supabase_service.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final SupabaseService _supabaseService;

  @observable
  User? user;

  @observable
  String? userName;

  @observable
  String? userAvatar;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  _AuthStore({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService() {
    _init();
  }

  void _init() {
    // Initialize user
    user = _supabaseService.currentUser;
    if (user != null) {
      _fetchProfile(user!.id);
    }

    // Listen to auth changes
    _supabaseService.authStateChanges.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      // Update user on any change
      user = session?.user;

      if (user != null) {
        _fetchProfile(user!.id);
      }

      if (event == AuthChangeEvent.signedOut) {
        user = null;
        userName = null;
        userAvatar = null;
      }
    });
  }

  Future<void> _fetchProfile(String userId) async {
    final profile = await _supabaseService.getProfile(userId);
    if (profile != null) {
      userName = profile['username'] as String?;
      userAvatar = profile['avatar_url'] as String?;
    }
  }

  @action
  Future<void> updateProfile({String? name, String? avatarUrl}) async {
    if (user == null) return;
    isLoading = true;
    errorMessage = null;
    try {
      await _supabaseService.updateProfile(
        userId: user!.id,
        username: name,
        avatarUrl: avatarUrl,
      );
      // Update local state
      if (name != null) userName = name;
      if (avatarUrl != null) userAvatar = avatarUrl;
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signUp(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final response = await _supabaseService.signUp(email, password);
      if (response.user != null) {
        user = response.user;
        await _supabaseService.updateProfile(userId: response.user!.id, email: email);
      }
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signIn(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final response = await _supabaseService.signIn(email, password);
      if (response.user != null) {
        user = response.user;
      }
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    errorMessage = null;
    try {
      await _supabaseService.signOut();
      user = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> resetPassword(String email) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _supabaseService.resetPasswordForEmail(email);
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
    }
  }
  
  bool get isAuthenticated => user != null;
}
