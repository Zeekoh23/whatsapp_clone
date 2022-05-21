import 'package:get/get.dart';

import '../bindings/individual_binding.dart';

import '../widgets/individual_card.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.individual;

  static final routes = [
    GetPage(
      name: _Paths.individual,
      page: () => IndividualCard(),
      binding: IndividualBinding(),
    ),
  ];
}
