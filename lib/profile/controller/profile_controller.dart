import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workflow_customer/core/api_provider.dart';
import '../model/user.dart';

class ProfileController extends GetxController {
  final _storage = GetStorage();

  late UserModel user;

  @override
  void onInit() async {
    super.onInit();
    user = UserModel.fromJson(_storage.read('user'));
  }
}
