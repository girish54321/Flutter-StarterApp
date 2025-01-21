import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reqres_app/DemoScreen/DemoScreen.dart';
import 'app.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: [
        GetPage(
            name: '/',
            page: () {
              return DemoScreen();
            })
      ],
    );
  }
}

FutureOr<void> main() async {
  runApp(const ReqResApp());
  // runApp(const DemoApp());
}
