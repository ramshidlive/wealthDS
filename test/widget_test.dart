import 'package:flutter_test/flutter_test.dart';

import 'package:my_design_system/main.dart';

void main() {
  testWidgets('Preview shows StatusPill matrix, StatBox, and AssetListItem',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DesignSystemPreviewApp());

    expect(find.text('KI Breached'), findsNWidgets(6));
    expect(find.text('Trade date'), findsOneWidget);
    expect(find.textContaining("09 Apr"), findsOneWidget);
    expect(find.textContaining('Monthly'), findsOneWidget);
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('US Dollar'), findsOneWidget);
    expect(find.text('Stock'), findsNWidgets(2));
  });
}
