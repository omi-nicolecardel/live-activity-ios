import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:live_activities/live_activities.dart';
import 'package:live_activity_app/model/order_tracker_model.dart';

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late Timer timer;
  String? time;
  final liveActivitiesPlugin = LiveActivities();
  OrderTrackerModel orderTracker = OrderTrackerModel(
    name: 'John Doe',
    status: 'Order Placed',
    progressValue: 0.2,
  );
  String? activityID;

  @override
  void initState() {
    super.initState();

    liveActivitiesPlugin.init(appGroupId: "group.ordertracker");
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      updateTime();
      if (activityID == null) {
        final id =
            await liveActivitiesPlugin.createActivity(orderTracker.toJson());
        setState(() {
          activityID = id;
          print(activityID);
        });
      } else {
        liveActivitiesPlugin.updateActivity(
            activityID ?? '', orderTracker.toJson());
      }
    });
  }

  void updateTime() {
    setState(() {
      time = DateFormat("HH:mm:ss").format(DateTime.now());
    });
  }

  void updateOrderStatus(OrderTrackerModel newOrderTracker) {
    setState(() {
      orderTracker = newOrderTracker;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F8FF),
                border: Border.all(color: const Color(0xFF0030FF)),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 15, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderTracker.status,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0030FF)),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xFF0030FF)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  time ?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0030FF)),
                                ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                width: 170,
                                child: LinearProgressIndicator(
                                  backgroundColor: Color(0xFFE8EAEE),
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  value: orderTracker.progressValue,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color(0xFF0030FF)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    bottom: 0,
                    child: SvgPicture.asset(
                      "assets/location-access.svg",
                      width: 200,
                      alignment: Alignment.bottomRight,
                      allowDrawingOutsideViewBox: false,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4F8FF),
                  foregroundColor: const Color(0xFF0030FF),
                ),
                onPressed: () {
                  setState(() {
                    updateOrderStatus(OrderTrackerModel(
                      name: 'John Doe',
                      status: 'Preparing order',
                      progressValue: 0.4,
                    ));
                  });
                },
                child: const Text('Preparing order')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4F8FF),
                  foregroundColor: const Color(0xFF0030FF),
                ),
                onPressed: () {
                  setState(() {
                    updateOrderStatus(OrderTrackerModel(
                      name: 'John Doe',
                      status: 'Ready to pick up',
                      progressValue: 0.6,
                    ));
                  });
                },
                child: const Text('Ready to pick up')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4F8FF),
                  foregroundColor: const Color(0xFF0030FF),
                ),
                onPressed: () {
                  setState(() {
                    updateOrderStatus(OrderTrackerModel(
                      name: 'John Doe',
                      status: 'On the way',
                      progressValue: 0.8,
                    ));
                  });
                },
                child: const Text('On the way')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4F8FF),
                  foregroundColor: const Color(0xFF0030FF),
                ),
                onPressed: () {
                  setState(() {
                    updateOrderStatus(OrderTrackerModel(
                      name: 'John Doe',
                      status: 'Delivered',
                      progressValue: 1.0,
                    ));
                  });
                },
                child: const Text('Delivered')),
          ],
        ),
      ),
    );
  }
}
