import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMController extends GetxController {
  late FirebaseMessaging messaging;
  late NotificationSettings settings;
  // final ApiProvider api = Get.find();

  @override
  void onInit() {
    super.onInit();

    messaging = FirebaseMessaging.instance;
    handleRequest();
  }

  void handleRequest() async {
    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  // void sendTopicMessage() async {
  //   messaging.send;
  //   FirebaseMessaging.instance.sendMessage()
  // }

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String topic,
      required String title,
      required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      // "registration_ids": userToken,
      "to": "/topics/$topic",
      "collapse_key": "type_a",
      "notification": {
        "title": '$title',
        "body": '$body',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'Bearer AAAAZbDCWss:APA91bG_9sXfwdApGM_SdhRROvRZEvEcfGCSMBxsEdw0qxa5FauvnY1REwtPvtJb5i1bxLNstQn2ygkgk_dBUvTWkEVTECe-ipAxWR2ysVl7xFPoLm6aKoeadYMNrv9rjBj1sTjGojmh' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      print('${response.statusCode}');
      // print('${response.}');
      print('${response.body}');
      // on failure do sth
      return false;
    }
  }

  // void onListen() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     log('Got a message whilst in the foreground!');
  //     log('Message data: ${message.data}');

  //     if (message.notification != null) {
  //       log('Message also contained a notification: ${message.notification}');
  //     }
  //   });
  // }

  // void subscribeToTopic() async {
  //   try {
  //     await Future.delayed(const Duration(seconds: 1));
  //     final Response response = await api.getApi('/api/events/reg/events/');
  //     final List responseBody = response.body['results'];
  //     List eventSlugs = [];
  //     for (var e in responseBody) {
  //       eventSlugs.add(e['event']?['slug']);
  //     }
  //     eventSlugs.forEach((e) async {
  //       await messaging.subscribeToTopic('$e');
  //     });
  //   } on Exception catch (e) {
  //     Get.snackbar('Network Error', "Please check your network connectivity.");
  //   }
  // }

  // void fetchToken() async {
  //   String? token = await messaging.getToken();
  //   log(token!);

  //   // TODO: Api call to register device token
  // }
}
