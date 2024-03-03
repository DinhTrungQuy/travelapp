// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travelapp/component/WishlistTile.dart';
import 'package:travelapp/model/Wishlist.dart';
import 'package:travelapp/model/place.dart';

class WishlistPage extends StatefulWidget {
  final String token;
  
  const WishlistPage({
    Key? key,
    required this.token,
   
  }) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Wishlist> wishlist = [];
  List<Place> places = [];
  bool loading = true;
  Future<List<Wishlist>> getWishlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    final response = await http.get(
      Uri.parse('https://quydt.speak.vn/api/wishlist'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode != 200) {
      return [];
    }
    List<dynamic> jsonData = jsonDecode(response.body);
    List<Wishlist> wishlists = Wishlist.fromJsonList(jsonData);
    return wishlists;
  }

  Future<List<Place>> getAllPlaces(List<Wishlist> wishlist) async {
    List<Future<Place>> futures = [];
    for (var item in wishlist) {
      futures.add(getPlace(item.placeId!));
    }
    return Future.wait(futures);
  }

  Future<Place> getPlace(String placeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    final response = await http.get(
      Uri.parse('https://quydt.speak.vn/api/place/${placeId}'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode != 200) {
      // loginStatus = false;
      throw Exception('Failed to get place');
    }
    Place place = Place.fromJson(jsonDecode(response.body));
    return place;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishlist().then((value) {
      getAllPlaces(value).then((value) => setState(() {
            places = value;
            loading = false;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        scrolledUnderElevation: 0,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: places.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemBuilder: (context, index) {
                return WishlistTile(
                  place: places[index],
                );
              },
            ),
    );
  }
}
