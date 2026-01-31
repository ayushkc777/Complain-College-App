import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complain_college_app/features/item/presentation/pages/report_complaint_page.dart';

void main() {
  testWidgets('ReportComplaintPage renders upload section', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ReportComplaintPage(),
      ),
    );

    expect(find.text('Report Item'), findsOneWidget);
    expect(find.text('Add Image'), findsOneWidget);
  });
}



