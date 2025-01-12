enum Flavor {
  reqres,
  reqres_dev,
  reqres_qa,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.reqres:
        return 'ReqRes';
      case Flavor.reqres_dev:
        return 'ReqRes DEV';
      case Flavor.reqres_qa:
        return 'ReqRes QA';
      default:
        return 'title';
    }
  }

}
