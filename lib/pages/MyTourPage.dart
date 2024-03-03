import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travelapp/component/BookingTile.dart';

import 'package:travelapp/model/Booking.dart';
import 'package:http/http.dart' as http;

class MyTourPage extends StatefulWidget {
  final String token;

  const MyTourPage({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<MyTourPage> createState() => _MyTourPageState();
}

class _MyTourPageState extends State<MyTourPage> {
  bool loading = true;
  List<Booking> bookingList = [];
  Future<List<Booking>> getBookingList() async {
    final response = await http
        .get(Uri.parse("https://quydt.speak.vn/api/booking"), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${widget.token}",
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return Booking.fromJsonList(data);
    }
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingList().then((value) {
      setState(() {
        loading = false;
        bookingList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tour'),
        centerTitle: true,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: ListView.builder(
                itemCount: bookingList.length,
                itemBuilder: (context, index) =>
                    BookingTile(booking: bookingList[index]),
              ),
            ),
    );
  }
}
