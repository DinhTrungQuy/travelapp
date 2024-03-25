// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travelapp/model/place.dart';

class StatusButton extends StatefulWidget {
  final Place place;
  final int status;
  final String bookingId;
  final Function onStatusChanged;
  const StatusButton({
    Key? key,
    required this.place,
    required this.status,
    required this.bookingId,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  State<StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends State<StatusButton> {
  Future<void> handleCancel() async {
    print('cancel');
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    await http.post(
        Uri.parse(
            'https://quydt.speak.vn/api/booking/cancel/${widget.bookingId}'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    widget.onStatusChanged();
  }

  Future<void> handleCheckin() async {
    print('cancel');
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    await http.post(
        Uri.parse(
            'https://quydt.speak.vn/api/booking/checkin/${widget.bookingId}'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    widget.onStatusChanged();
  }

  Future<void> handleCheckout() async {
    print('cancel');
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    await http.post(
        Uri.parse(
            'https://quydt.speak.vn/api/booking/checkout/${widget.bookingId}'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    widget.onStatusChanged();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comfirm Cancel'),
          content: const Text(
            'Are you sure you want to cancel this booking?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                handleCancel();
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
    Future<void> handleRating(int ratingValue, String comment) async {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String userId = prefs.getString("userId") ?? "";
      final response = await http.post(
          Uri.parse('https://quydt.speak.vn/api/Rating/${widget.bookingId}'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            "userId": userId,
            "placeId": widget.place.id,
            "ratingValue": ratingValue.toString(),
            "comment": comment,
          }));
      print(response.statusCode);
      print(response.body);
      widget.onStatusChanged();
    }

    final dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Rating Your Tour',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        'Tap a star to set your rating.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.network(
        widget.place.imageUrl,
        fit: BoxFit.cover,
      ),
      submitButtonText: 'Submit',

      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        final prefs = await SharedPreferences.getInstance();
        String userId = prefs.getString("userId") ?? "";
        await handleRating(response.rating.round(), response.comment);
        print('rating: ${response.rating}, comment: ${response.comment}');
        print('user $userId');
      },
    );

    if (widget.status == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _dialogBuilder(context);
                });
                handleCancel();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () => _dialogBuilder(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                handleCheckin();
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Checkin",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (widget.status == 1) {
      return Expanded(
        child: GestureDetector(
          onTap: handleCheckout,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              "Checkout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else if (widget.status == 2) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible:
                  true, // set to false if you want to force a rating
              builder: (context) => dialog,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.amber[300],
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              "Rate this",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
