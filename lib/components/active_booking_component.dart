import 'package:flutter/material.dart';
import 'package:workflow_customer/custom_widget/space.dart';
import 'package:workflow_customer/main.dart';
import 'package:workflow_customer/models/active_bookings_model.dart';
import 'package:workflow_customer/screens/cancel_booking_screen.dart';
import 'package:workflow_customer/utils/colors.dart';
import 'package:workflow_customer/utils/images.dart';

class ActiveBookingComponent extends StatelessWidget {
  final ActiveBookingsModel? activeBookingsModel;
  final int index;

  ActiveBookingComponent(this.index, {this.activeBookingsModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CancelBookingScreen(activeId: index)),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activeBookingsModel!.serviceName,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ],
                ),
                Space(4),
                Divider(color: dividerColor, thickness: 1),
                Space(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        child: Image.asset(home, fit: BoxFit.cover),
                      ),
                    ),
                    Space(8),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(activeBookingsModel!.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        Space(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined,
                                color: orangeColor, size: 16),
                            Space(2),
                            Text(activeBookingsModel!.date,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Space(10),
                            Text("at",
                                style: TextStyle(
                                    color: orangeColor, fontSize: 12)),
                            Space(2),
                            Text(activeBookingsModel!.time,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Space(4),
                Space(15),
                Divider(color: dividerColor, thickness: 1),
                Space(4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
