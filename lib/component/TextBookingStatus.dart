// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextBookingStatus extends StatelessWidget {
  final int status;
  const TextBookingStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      return Text(
        "Pending",
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else if (status == 1) {
      return Text(
        "On going",
        style: TextStyle(
            color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else if (status == 2) {
      return Text(
        "Finished",
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else if (status == 3) {
      return Text(
        "Cancelled",
        style: TextStyle(
            color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
    return Text(
      "Error",
      style: TextStyle(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
