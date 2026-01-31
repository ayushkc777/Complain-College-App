import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complain_college_app/features/auth/presentation/pages/login_page.dart';
import '../helpers/test_asset_bundle.dart';

void main() {
  testWidgets('LoginPage renders login form', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DefaultAssetBundle(
            bundle: TestAssetBundle(),
            child: const LoginPage(),
          ),
        ),
      ),
    );

    expect(find.text('Student Portal'), findsOneWidget);
    expect(find.text('Login'), findsWidgets);
  });
}


