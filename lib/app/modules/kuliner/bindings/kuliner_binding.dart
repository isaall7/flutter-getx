import 'package:get/get.dart';

import '../controllers/kuliner_controller.dart';

class KulinerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KulinerController>(
      () => KulinerController(),
    );
  }
}
