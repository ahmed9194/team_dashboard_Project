import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team_dashboard/main.dart';

void main() {
  testWidgets('App builds successfully smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TeamDashboardApp() as Widget);

    // Verify that the loading indicator is shown initially.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

class TeamDashboardApp {
  const new();
}