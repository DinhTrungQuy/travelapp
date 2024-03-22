import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    final response = await http
        .get(Uri.parse("https://quydt.speak.vn/api/booking"), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${token}",
    });
    print(response.statusCode);
    print(widget.token);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return Booking.fromJsonList(data);
    }
    return [];
  }

  void refreshBookings() {
    getBookingList().then((value) {
      setState(() {
        bookingList = value;
      });
    });
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
        scrolledUnderElevation: 0,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                getBookingList().then((value) {
                  setState(() {
                    bookingList = value;
                  });
                });
              },
              child: Center(
                child: Container(
                  child: ListView.builder(
                    itemCount: bookingList.length,
                    itemBuilder: (context, index) => BookingTile(
                        booking: bookingList[index],
                        onStatusChanged: refreshBookings),
                  ),
                ),
              ),
            ),
    );
  }
}
