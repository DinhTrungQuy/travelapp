import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/component/mybutton.dart';
import 'package:travelapp/model/Booking.dart';
import 'package:travelapp/model/Place.dart';
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
    print('BookingPage.dart placeId: ${booking.placeId}');
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
    // TODO: implement initState
    super.initState();

    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    checkOutTime =
        updateCheckoutTime(dateController.text, widget.place.durationDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Booking details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
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
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Place name",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.place.name,
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          SizedBox(
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
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                      decoration: InputDecoration(
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
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          SizedBox(
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
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Check-out",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    checkOutTime,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          SizedBox(
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
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Duration",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "${widget.place.durationDays} days",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          SizedBox(
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
                child: Icon(
                  Icons.people,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        quantityCount.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text("Payment Summary",
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${quantityCount}x${widget.place.price}\$  ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.place.price * quantityCount}\$",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.place.price * quantityCount}\$",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
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
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.place.price * quantityCount}\$",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          MyButton(
            onTap: () {
              print('BookingPage.dart: ${widget.place.id}');
              Booking booking = new Booking(
                placeId: widget.place.id,
                quantity: quantityCount,
                checkInTime: dateController.text,
                totalPrice: widget.place.price * quantityCount,
              );
              handleBooking(booking);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            title: "Book now",
          )
        ],
      ),
    );
  }
}
