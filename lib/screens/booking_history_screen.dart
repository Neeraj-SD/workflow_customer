import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_customer/components/booking_history_component.dart';
import 'package:workflow_customer/job/controller/job_controller.dart';
import 'package:workflow_customer/models/last_bookings_model.dart';

class BookingHistoryScreen extends StatelessWidget {
  BookingHistoryScreen({Key? key}) : super(key: key);

  final JobController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: controller.pastJobs.length,
          itemBuilder: (BuildContext context, int index) {
            return BookingHistoryComponent(index,
                lastBooking: controller.pastJobs[index]);
          },
        ),
      ),
    );
  }
}
