import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelapp/component/status_button.dart';
import 'package:travelapp/component/text_booking_status.dart';

import 'package:travelapp/model/booking.dart';
import 'package:travelapp/model/place.dart';
import 'package:http/http.dart' as http;

class BookingTile extends StatefulWidget {
  final Booking booking;
  final Function onStatusChanged;
  const BookingTile({
    Key? key,
    required this.booking,
    required this.onStatusChanged,
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
    super.initState();
    getPlaceById(widget.booking.placeId!).then((value) => setState(() {
          place = value;
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const SizedBox.shrink()
        : Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(15),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  place!.imageUrl,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 200,
                ),
              ),
              title: Text(
                place!.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: TextBookingStatus(status: widget.booking.status!),
              trailing: const Text('Details', style: TextStyle(fontSize: 14)),
              // collapsedBackgroundColor: Colors.red[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.topLeft,
              childrenPadding: const EdgeInsets.all(15),
              children: [
                Text("Passenger(s): ${widget.booking.quantity}"),
                const SizedBox(height: 5),
                Text("Total Price: ${widget.booking.totalPrice}"),
                const SizedBox(height: 5),
                Text("Status: ${widget.booking.status}"),
                const SizedBox(height: 5),
                Text("Check Out Time: ${widget.booking.checkOutTime}"),
                const SizedBox(height: 5),
                Text("Created At: ${widget.booking.createdAt}"),
                const SizedBox(height: 5),
                Text("Updated At: ${widget.booking.updatedAt}"),
                const SizedBox(height: 5),
                Text("Rating: ${widget.booking.rating}"),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: StatusButton(
                    place: place!,
                    status: widget.booking.status!,
                    bookingId: widget.booking.id!,
                    onStatusChanged: widget.onStatusChanged,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
  }
}
