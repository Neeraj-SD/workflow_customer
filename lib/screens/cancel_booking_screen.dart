import 'package:flutter/material.dart';
import 'package:home_hub/screens/last_booking_screen.dart';
import 'package:home_hub/utils/colors.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../models/active_bookings_model.dart';

class CancelBookingScreen extends StatefulWidget {
  final int activeId;

  const CancelBookingScreen({Key? key, required this.activeId}) : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  String? refundMethod;
  String? reasonForCancel;
  int itemCount = 1;

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Please select valid details'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Job Details",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                shape: StadiumBorder(),
              ),
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text("Accept Bid")),
              onPressed: () {
                if (refundMethod == null) {
                  _showAlertDialog();
                } else if (reasonForCancel == null) {
                  _showAlertDialog();
                } else {
                  cancelBooking(widget.activeId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LastBookingScreen(cancel: true)),
                  );
                }
              },
            ),
          );
        },
        onClosing: () {},
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: appData.isDark ? cardColorDark : cardColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.10,
                                      width: MediaQuery.of(context).size.height * 0.10,
                                      child: Image.asset('assets/images/home.jpg', fit: BoxFit.cover),
                                    ),
                                  ),
                                  Space(16),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activeBooking[widget.activeId].serviceName,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                                      ),
                                      Space(4),
                                      Text(
                                        activeBooking[widget.activeId].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: greyColor, fontSize: 12),
                                      ),
                                      Space(4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.watch_later_outlined, color: greyColor, size: 14),
                                          Space(2),
                                          Text(
                                            activeBooking[widget.activeId].time,
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                          ),
                                          Space(2),
                                          Text("on", style: TextStyle(color: greyColor, fontSize: 8)),
                                          Space(2),
                                          Text("Thursday", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: (BorderRadius.circular(5)),
                                  border: Border.all(width: 1, color: itemCountContainerBorder),
                                  color: itemCountContainer,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.remove, color: blackColor, size: 16),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 3),
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: whiteColor),
                                      child: Text(itemCount.toString(), style: TextStyle(color: blackColor, fontSize: 16)),
                                    ),
                                    Icon(Icons.add, color: blackColor, size: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Space(42),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            
                          )
                        ],
                      ),
                    ),
                  ),
                  Space(32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Summary",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                    ],
                  ),
                  Space(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Job Description",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: greyColor, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                     
                    ],
                  ),
                  Space(8),
                  
                  Space(8),
                  Divider(indent: 8, endIndent: 8, color: greyColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Current Bids", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                      
                    ],
                  ),
                  
                  Space(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Worker 1",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: greyColor, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text("₹1000", textAlign: TextAlign.start, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Space(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Worker 2",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: greyColor, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text("₹1500", textAlign: TextAlign.start, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            
            Space(16),
            
            Space(80),
          ],
        ),
      ),
    );
  }
}
