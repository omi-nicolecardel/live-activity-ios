import 'package:intl/intl.dart';

class OrderTrackerModel {
  String name;
  String status;
  double progressValue;

  OrderTrackerModel({
    required this.name,
    required this.status,
    required this.progressValue,
  });

  toJson() => {
        'name': name,
        'status': status,
        'progressValue': progressValue,
        'time': DateFormat("HH:mm:ss").format(DateTime.now())
      };

  DateTime get dateTime => DateTime.now();
}
