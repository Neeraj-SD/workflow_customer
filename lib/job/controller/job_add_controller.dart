import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workflow_customer/auth/model/user.dart';
import 'package:workflow_customer/core/api_provider.dart';
import 'package:workflow_customer/job/model/tag.dart';

class JobAddController extends GetxController {
  final ApiProvider api = Get.find();
  final _getStorage = GetStorage();
  final storageRef = FirebaseStorage.instance.ref();
  late Reference? imagesRef = storageRef.child('images');
  late TextEditingController locationController;
  late TextEditingController descriptionController;

  final tags = <TagModel>[].obs;
  late TagModel selectedTag;
  final selectedTagName = ''.obs;
  var pickedImage = ''.obs;
  var isPosting = false.obs;

  String location = '';
  String description = '';

  @override
  void onInit() {
    super.onInit();
    getTags();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
  }

  void getTags() async {
    //get Tag
    final result = await api.getApi('/api/job/tags/');
    tags.value = tagModelFromJson(result.body);
  }

  void setSelectedTag(TagModel tag) {
    selectedTag = tag;
    selectedTagName.value = tag.name ?? '';
  }

  // void compressImage(String uri) async {
  //   try {
  //     File imageFile = File.fromUri(Uri.parse(uri));
  //     final targetPath = '${imageFile.absolute.path}${DateTime.now()}.png';

  //     final result = await FlutterImageCompress.compressAndGetFile(
  //       format: CompressFormat.png,
  //       imageFile.absolute.path,
  //       targetPath,
  //       quality: 80,
  //       minHeight: 640,
  //       minWidth: 480,
  //     );

  //     print('image Size: ' + imageFile.lengthSync().toString());
  //     print('result Size: ${result?.lengthSync()}');

  //     uploadStory(result!.absolute.path);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  void uploadJob(String uri) async {
    // Get.back();
    try {
      isPosting(true);

      File imageFile = File.fromUri(Uri.parse(uri));
      final user = userModelFromJson(_getStorage.read('user'));

      final imageLocation = imagesRef?.child('${user.email}-${DateTime.now()}');

      await imageLocation?.putFile(imageFile);
      final imageUrl = await imageLocation!.getDownloadURL();
      log(imageUrl);

      // Post to api

      final data = {
        'location': location,
        'description': description,
        'time_minutes': 0,
        'tags': [
          selectedTag.id,
        ],
        'image': imageUrl,
      };

      await api.postApi('/api/job/jobs/', data);
      Get.back();
      // fetchAllStories();
      Get.snackbar(
        'Job Added',
        'Successfully ✅',
      );

      locationController.clear();
      descriptionController.clear();
      pickedImage.value = '';
      selectedTagName.value = '';
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isPosting(false);
    }
  }

  void pickImage() async {
    // final ImagePickerPlatform imagePickerImplementation =
    //     ImagePickerPlatform.instance;
    // if (imagePickerImplementation is ImagePickerAndroid) {
    // }
    // imagePickerImplementation.useAndroidPhotoPicker = true;

    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    print(image?.path);
    if (image == null) return;
    pickedImage.value = image.path;
  }

  void postJob() async {
    if (selectedTagName.isEmpty) return;
    if (locationController.text.isEmpty) return;
    if (descriptionController.text.isEmpty) return;
    // if (description.isEmpty) return;
    if (pickedImage.value.isEmpty) return;

    location = locationController.text;
    description = descriptionController.text;

    uploadJob(pickedImage.value);
  }
}
