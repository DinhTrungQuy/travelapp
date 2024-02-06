import 'package:flutter/material.dart';
import 'package:travelapp/component/back-button.dart';
import 'package:travelapp/component/bookmark-button.dart';
import 'package:travelapp/model/place.dart';

class PlaceDetail extends StatefulWidget {
  final Place place;
  const PlaceDetail({super.key, required this.place});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackArrowButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            BookmarkButton(
              onTap: () async {
                //async bookmark
                print('BookmarkButton');
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              widget.place.image,
              width: double.maxFinite,
              height: 500,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              widget.place.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.place.location,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.place.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ));
  }
}
