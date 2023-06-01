import 'package:get/get.dart';
import 'package:workflow_customer/auth/controller/auth_controller.dart';
import 'package:workflow_customer/core/api_provider.dart';
import 'package:workflow_customer/job/controller/job_add_controller.dart';
import 'package:workflow_customer/profile/controller/profile_controller.dart';

class GetXDependencyInjector {
  void onInit() {
    Get.put(ApiProvider());
    Get.put(AuthController());

    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => JobAddController(), fenix: true);
  }
}
