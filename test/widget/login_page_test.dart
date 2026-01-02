import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sophy/core/store/auth_store.dart';
import 'package:sophy/features/presentation/pages/login/view/mobile/login_page_mobile.dart';

@GenerateMocks([AuthStore])
import 'login_page_test.mocks.dart';

void main() {
  late MockAuthStore mockAuthStore;

  setUp(() {
    mockAuthStore = MockAuthStore();
    GetIt.instance.registerSingleton<AuthStore>(mockAuthStore);
    
    // Stub observables and common properties
    when(mockAuthStore.isLoading).thenReturn(false);
    when(mockAuthStore.errorMessage).thenReturn(null);
    when(mockAuthStore.user).thenReturn(null);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('LoginPage shows login form correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPageMobile()));

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Email & Password
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Entering text and tapping login calls store', (WidgetTester tester) async {
    when(mockAuthStore.signIn(any, any)).thenAnswer((_) async {});

    await tester.pumpWidget(const MaterialApp(home: LoginPageMobile()));

    // Find fields by finding the parent TextField or using semantics, but finding by ancestor is reliable
    // Note: The code uses TextFormField with labelText.
    await tester.enterText(find.ancestor(of: find.text('Email'), matching: find.byType(TextFormField)), 'test@test.com');
    await tester.enterText(find.ancestor(of: find.text('Password'), matching: find.byType(TextFormField)), 'password');
    
    await tester.tap(find.text('Login'));
    await tester.pump(); // Start future
    
    verify(mockAuthStore.signIn('test@test.com', 'password')).called(1);
  });
  
  testWidgets('Shows error message when store has error', (WidgetTester tester) async {
    when(mockAuthStore.errorMessage).thenReturn('Invalid credentials');
    
    await tester.pumpWidget(const MaterialApp(home: LoginPageMobile()));
    await tester.pump(); // Trigger Observer rebuild

    expect(find.text('Invalid credentials'), findsOneWidget);
  });
}
