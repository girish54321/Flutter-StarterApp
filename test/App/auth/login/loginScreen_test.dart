import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:reqres_app/App/auth/login/loginScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('loginScreen ...', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginScreen(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pump();

    final emalInput = find.byKey(const Key('emal-input-form'));
    expect(emalInput, findsOneWidget);

    final passwordInput = find.byKey(const Key('password-input-form'));
    expect(passwordInput, findsOneWidget);

    final loginButton = find.byKey(const Key('login-button'));
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);

    await tester.enterText(emalInput, 'girish@gmail.com');
    await tester.enterText(passwordInput, '123456');

    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Email is required'), findsNothing);
    expect(find.text('Password is required'), findsNothing);
  });
}
