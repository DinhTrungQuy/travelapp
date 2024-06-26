import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/component/my_button.dart';
import 'package:travelapp/model/booking.dart';
import 'package:travelapp/model/place.dart';
import 'package:http/http.dart' as http;

class BookingPage extends StatefulWidget {
  final Place place;
  const BookingPage({super.key, required this.place});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int quantityCount = 0;
  bool loading = true;
  String checkOutTime = "";
  final dateController = TextEditingController();
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  Future<void> handleBooking(Booking booking) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    await http.post(Uri.parse('https://quydt.speak.vn/api/booking'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          "placeId": booking.placeId,
          "quantity": booking.quantity,
          "checkInTime": booking.checkInTime,
          "totalPrice": booking.totalPrice,
          "status": 0,
        }));
  }

  String updateCheckoutTime(String checkinTime, int durationDays) {
    if (checkinTime.isEmpty) {
      return '';
    }
    DateTime dateTime = DateTime.parse(checkinTime);
    return DateFormat('yyyy-MM-dd')
        .format(dateTime.add(Duration(days: durationDays)));
  }

  @override
  void initState() {
    super.initState();

    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    checkOutTime =
        updateCheckoutTime(dateController.text, widget.place.durationDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Booking details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Place name",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.place.name,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Check-in",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (date != null) {
                          dateController.text =
                              DateFormat('yyyy-MM-dd').format(date);
                          setState(() {
                            checkOutTime = updateCheckoutTime(
                                dateController.text, widget.place.durationDays);
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Select date',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        // contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Check-out",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    checkOutTime,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Duration",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "${widget.place.durationDays} days",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.people,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Passenger(s)",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        quantityCount.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Payment Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${quantityCount}x${widget.place.price}\$  ",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.place.price * quantityCount}\$",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.place.price * quantityCount}\$",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                "0\$",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.place.price * quantityCount}\$",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
            onTap: () {
              Booking booking = Booking(
                placeId: widget.place.id,
                quantity: quantityCount,
                checkInTime: dateController.text,
                totalPrice: widget.place.price * quantityCount,
              );
              handleBooking(booking);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Booking Complete'),
                  content: const Text('Your booking has been completed!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              // Navigator.pop(context);
              // Navigator.pop(context);
            },
            title: "Book now",
          )
        ],
      ),
    );
  }
}
