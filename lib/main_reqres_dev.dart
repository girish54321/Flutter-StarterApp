import 'package:get_storage/get_storage.dart';

import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.reqres_dev;
  await GetStorage.init();

  await runner.main();
}
