import 'package:get/get.dart';
import 'package:workflow_customer/auth/controller/auth_controller.dart';
import 'package:workflow_customer/core/api_provider.dart';

class GetXDependencyInjector {
  void onInit() {
    Get.put(ApiProvider());
    Get.put(AuthController());
  }
}
