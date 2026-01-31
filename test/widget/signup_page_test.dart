import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complain_college_app/features/auth/presentation/pages/signup_page.dart';

void main() {
  testWidgets('SignupPage renders create account UI', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SignupPage(),
        ),
      ),
    );

    expect(find.text('Create Student Account'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });
}


