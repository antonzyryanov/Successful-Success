import 'package:flutter_test/flutter_test.dart';

import 'package:successful_success/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(SuccessfulSuccessApp());

    expect(find.text('1'), findsNothing);
    await tester.pump();

    expect(find.text('0'), findsNothing);
  });
}
