import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sophy/features/music/data/models/track_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // --- Auth ---

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<AuthResponse> signUp(String email, String password) async {
    return await _client.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> resetPasswordForEmail(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  // --- Profile ---

  Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return response;
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }

  Future<void> updateProfile({
    required String userId,
    String? email,
    String? username,
    String? avatarUrl,
  }) async {
    try {
      final updates = {
        'id': userId,
        'updated_at': DateTime.now().toIso8601String(),
        if (email != null) 'email': email,
        if (username != null) 'username': username,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      };
      await _client.from('profiles').upsert(updates);
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  // --- Database ---

  Future<List<TrackModel>> getTracks() async {
    try {
      final response = await _client
          .from('tracks')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((e) => TrackModel.fromJson(e)).toList();
    } catch (e) {
      // Handle error or rethrow
      print('Error fetching tracks: $e');
      return [];
    }
  }

  Future<void> saveTrack(TrackModel track) async {
    try {
      await _client.from('tracks').insert(track.toJson());
    } catch (e) {
      print('Error saving track: $e');
      rethrow;
    }
  }

  // --- Storage ---

  Future<String> uploadFile(File file, String bucket, String path) async {
    try {
      await _client.storage.from(bucket).upload(path, file);
      final publicUrl = _client.storage.from(bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      print('Error uploading file to $bucket: $e');
      rethrow;
    }
  }
}
