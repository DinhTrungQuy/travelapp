import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/component/wishlist_button.dart';
import 'package:travelapp/component/add_to_cart_bar.dart';
import 'package:travelapp/component/back_button.dart';

import 'package:travelapp/model/place.dart';

class PlaceDetail extends StatefulWidget {
  final Place place;
  const PlaceDetail({super.key, required this.place});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool loading = true;
  bool loginStatus = false;
  bool isWishlisted = false;
  String token = "";
  String userId = "";
  Future<void> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId") ?? "";
  }

  Future<bool> getWishStatus(String userId, String placeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    final response = await http.get(
      Uri.parse("https://quydt.speak.vn/api/wishlist/$placeId"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> handleAddWishlist(String userId, String placeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    await http.post(
      Uri.parse("https://quydt.speak.vn/api/wishlist"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=utf-8',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        "userId": userId,
        "placeId": placeId,
      }),
    );
  }

  Future<void> handleDeleteWishlist(String userId, String placeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    await http.delete(
      Uri.parse("https://quydt.speak.vn/api/wishlist/$placeId"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=utf-8',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
  }

  Future initialize() async {
    await getUserId();
    await getWishStatus(userId, widget.place.id).then((value) {
      setState(() {
        isWishlisted = value;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: loading
          ? null
          : AppBar(
              surfaceTintColor: Colors.transparent,
              leadingWidth: 71,
              leading: Container(
                margin: const EdgeInsets.only(left: 15),
                child: BackArrowButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: WishlistButton(
                    isWishlisted: isWishlisted,
                    onTapToList: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (prefs.getString('token') == null ||
                          prefs.getString('token') == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "You need to login first.",
                              style: TextStyle(fontSize: 18),
                            ),
                            backgroundColor: Colors.red[400],
                          ),
                        );
                      } else {
                        await handleAddWishlist(userId, widget.place.id);
                        setState(() {
                          isWishlisted = true;
                        });
                      }
                    },
                    onTapToRemove: () async {
                      await handleDeleteWishlist(userId, widget.place.id);
                      setState(() {
                        isWishlisted = false;
                      });
                    },
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
            ),
      extendBodyBehindAppBar: true,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.network(
                        widget.place.imageUrl,
                        width: double.maxFinite,
                        height: size.height / 2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: size.height / 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(35),
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              widget.place.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red[400],
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.place.location,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.place.rating,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                RatingBarIndicator(
                                  rating: double.parse(widget.place.rating),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.red[400],
                                  ),
                                  itemCount: 5,
                                  itemSize: 20,
                                  // direction: Axis.vertical,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TabBar(
                              controller: _tabController,
                              labelColor: Colors.red[400],
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.red[400],
                              tabs: const [
                                Tab(
                                  icon: Icon(Icons.info_outline),
                                  text: 'About',
                                ),
                                Tab(
                                  icon: Icon(Icons.photo),
                                  text: 'Photos',
                                ),
                                // Tab(
                                //   icon: Icon(Icons.map),
                                //   text: 'Map',
                                // ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: size.height * 0.3,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Description',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        widget.place.description,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Photos',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.network(
                                            widget.place.imageUrl,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 10),
                                          Image.network(
                                            widget.place.imageUrl,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       'Map',
                                  //       style: const TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(height: 10),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AddToCartBar(
                    place: widget.place,
                  ),
                ),
              ],
            ),
    );
  }
}
