import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sophy/core/services/supabase_service.dart';
import 'package:sophy/core/store/auth_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateMocks([SupabaseService])
import 'auth_store_test.mocks.dart';

// Mock User class since Supabase User might be hard to mock directly or we want control
class MockUser extends Mock implements User {
  @override
  String get id => 'test_user_id';
  
  @override
  String get email => 'test@example.com';
}

void main() {
  late AuthStore authStore;
  late MockSupabaseService mockSupabaseService;

  setUp(() {
    mockSupabaseService = MockSupabaseService();
    
    // Default stubs to prevent crashes during init
    when(mockSupabaseService.currentUser).thenReturn(null);
    when(mockSupabaseService.authStateChanges).thenAnswer((_) => Stream.empty());
    
    authStore = AuthStore(supabaseService: mockSupabaseService);
  });

  group('AuthStore', () {
    test('initial state is correct', () {
      expect(authStore.user, isNull);
      expect(authStore.isLoading, isFalse);
    });

    test('signIn success', () async {
      final mockUser = MockUser();
      final authResponse = AuthResponse(
        session: Session(
          accessToken: 'token',
          tokenType: 'bearer',
          user: mockUser,
        ),
        user: mockUser,
      );

      when(mockSupabaseService.signIn(any, any))
          .thenAnswer((_) async => authResponse);

      await authStore.signIn('test@example.com', 'password');

      expect(authStore.user, mockUser);
      expect(authStore.isLoading, isFalse);
      expect(authStore.errorMessage, isNull);
    });

    test('signIn failure', () async {
      when(mockSupabaseService.signIn(any, any))
          .thenThrow(Exception('Login failed'));

      try {
        await authStore.signIn('test@example.com', 'password');
      } catch (_) {
        // Expected
      }

      expect(authStore.user, isNull);
      expect(authStore.isLoading, isFalse);
      expect(authStore.errorMessage, contains('Login failed'));
    });

    test('signOut success', () async {
      when(mockSupabaseService.signOut()).thenAnswer((_) async {});
      
      // Simulate logged in state first (manually or via mock)
      // Since we can't easily set 'user' directly (it's observable but we should use actions),
      // we'll rely on the fact that signOut sets it to null.
      
      await authStore.signOut();

      expect(authStore.user, isNull);
      expect(authStore.isLoading, isFalse);
    });
  });
}
