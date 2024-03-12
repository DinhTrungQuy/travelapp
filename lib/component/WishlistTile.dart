// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelapp/model/Place.dart';
import 'package:travelapp/pages/PlaceDetail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WishlistTile extends StatefulWidget {
  final Place place;
  WishlistTile({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends State<WishlistTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void navigateToPalaceDetail() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceDetail(
            place: widget.place,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: navigateToPalaceDetail,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Positioned(
                    child: Image.network(
                      widget.place.imageUrl,
                      // width: 100,
                      height: size.width * 0.5 - 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: size.width * 0.5 - 25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: size.width * 0.5 - 70,
                              child: Text(
                                widget.place.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: RatingBarIndicator(
                            rating: double.parse(widget.place.rating),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemCount: 5,
                            itemSize: 16,
                            // direction: Axis.vertical,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   width: 20,
            // ),
          ],
        ),
      ),
    );
  }
}
