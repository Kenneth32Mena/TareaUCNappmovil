import 'package:flutter_test/flutter_test.dart';
import 'package:tareas_ucn/main.dart';

void main() {
  testWidgets('Tareas UCN smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TareasUcnApp());
    expect(find.text('Tareas UCN'), findsWidgets);
  });
}
