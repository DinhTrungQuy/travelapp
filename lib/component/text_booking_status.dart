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
      return const Text(
        "Pending",
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else if (status == 1) {
      return const Text(
        "On going",
        style: TextStyle(
            color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else if (status == 2) {
      return const Text(
        "Finished",
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else if (status == 3) {
      return Text(
        "Rated",
        style: TextStyle(
            color: Colors.amber[800], fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else if (status == 4) {
      return const Text(
        "Cancelled",
        style: TextStyle(
            color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
    return const Text(
      "Error",
      style: TextStyle(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
