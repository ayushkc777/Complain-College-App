import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complain_college_app/features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  testWidgets('DashboardPage renders navigation labels', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DashboardPage(),
      ),
    );

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Complaints'), findsWidgets);
    expect(find.text('Updates'), findsWidgets);
    expect(find.text('Profile'), findsWidgets);
  });
}


