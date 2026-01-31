import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complain_college_app/features/dashboard/presentation/pages/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders recent complaints section', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Recent Complaints'), findsOneWidget);
  });
}


