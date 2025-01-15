import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:reqres_app/newcode/conunter_screen.dart';

void main() {
  testWidgets('Counter increments when button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: MyTestScreen(
          title: "",
        ),
      ),
    );
    final counterText = find.byKey(Key('counterText'));
    final incrementButton = find.byKey(Key('incrementButton'));
    expect(counterText, findsOneWidget);
    expect(incrementButton, findsOneWidget);
    expect(tester.widget<Text>(counterText).data, '0');
    await tester.tap(incrementButton);
    await tester.pump();
    expect(tester.widget<Text>(counterText).data, '1');
  });
}
