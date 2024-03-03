import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:travelapp/model/Booking.dart';
import 'package:travelapp/model/Place.dart';
import 'package:http/http.dart' as http;

class BookingTile extends StatefulWidget {
  final Booking booking;
  const BookingTile({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  State<BookingTile> createState() => _BookingTileState();
}

Future<Place> getPlaceById(String placeId) async {
  final response =
      await http.get(Uri.parse("https://quydt.speak.vn/api/Place/$placeId"));
  return Place.fromJson(jsonDecode(response.body));
}

class _BookingTileState extends State<BookingTile> {
  Place? place;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlaceById(widget.booking.placeId!).then((value) => setState(() {
          place = value;
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(4, 8), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.all(15),
                  leading: ClipRRect(
                    child: Image.network(
                      place!.imageUrl,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 200,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(
                    place!.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('On going',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  trailing: Text('Details', style: TextStyle(fontSize: 14)),
                  // collapsedBackgroundColor: Colors.red[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topLeft,
                  childrenPadding: EdgeInsets.all(15),
                  children: [
                    Text("Quantity: ${widget.booking.quantity}"),
                    Text("Total Price: ${widget.booking.totalPrice}"),
                    Text("Status: ${widget.booking.status}"),
                    Text("Check Out Time: ${widget.booking.checkOutTime}"),
                    Text("Created At: ${widget.booking.createdAt}"),
                    Text("Updated At: ${widget.booking.updatedAt}"),
                    Text("Rating: ${widget.booking.rating}"),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
  }
}
