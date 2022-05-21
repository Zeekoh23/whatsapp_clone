import 'package:get/get.dart';

import '../controllers/individual_controller.dart';

class IndividualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualController>(() => IndividualController());
  }
}
