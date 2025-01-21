import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reqres_app/App/auth/login/loginScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:reqres_app/network/remote_data_source.dart';

class MockClient extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

class MockHTTPClient extends Mock implements Client {}

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}

class AllNullFakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return null;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return null;
  }

  @override
  Future<String?> getLibraryPath() async {
    return null;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return null;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return null;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return null;
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return null;
  }

  @override
  Future<String?> getDownloadsPath() async {
    return null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockHTTPClient mockHTTPClient;
  late RemoteDataSource remoteDataSource;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    remoteDataSource = RemoteDataSource(mockHTTPClient);
    // registerFallbackValue(FakeUri());
  });

  testWidgets('loginScreen shows error messages for invalid inputs',
      (tester) async {
    // // Mock HTTP response
    // when(
    //   () => mockHTTPClient.post(
    //     Uri.parse('https://reqres.in/api/login'),
    //   ),
    // ).thenAnswer((_) async {
    //   return Response('''
    //         {
    //             "token": "QpwL5tke4Pnpja7X4"
    //         }
    //         ''', 500);
    // });

    // Build the widget
    await tester.pumpWidget(
      GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Find input fields and button
    final emailInput = find.byKey(const Key('emal-input-form'));
    final passwordInput = find.byKey(const Key('password-input-form'));
    final loginButton = find.byKey(const Key('login-button'));

    expect(emailInput, findsOneWidget);
    expect(passwordInput, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Tap login button without inputs
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);

    // Enter valid inputs
    await tester.enterText(emailInput, 'girish@gmail.com');
    await tester.enterText(passwordInput, '123456');
    // Mock HTTP response
    when(
      () => mockHTTPClient.post(
        Uri.parse('https://reqres.in/api/login'),
      ),
    ).thenAnswer((_) async {
      return Response('''
            {
                "token": "QpwL5tke4Pnpja7X4"
            }
            ''', 200);
    });
    await tester.tap(loginButton);

    // await tester.pumpAndSettle();
    // expect(find.text('Email is required'), findsNothing);
    // expect(find.text('Password is required'), findsNothing);
  });
}
