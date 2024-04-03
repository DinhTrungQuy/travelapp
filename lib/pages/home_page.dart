// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:travelapp/component/place_tile.dart';
import 'package:travelapp/model/place.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool loading = true;
  List<Place> places = [];
  List<Place> parsePlaces(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Place>((json) => Place.fromJson(json)).toList();
  }

  Future<List<Place>> fetchPlaces() async {
    var response =
        await http.get(Uri.parse('https://quydt.speak.vn/api/place'));
    return parsePlaces(response.body);
  }

  @override
  void initState() {
    super.initState();
    fetchPlaces().then((value) => setState(() {
          places = value;
          loading = false;
        }));
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Du lịch Việt Nam',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Khám phá vẻ đẹp tự nhiên và văn hóa của Việt Nam',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TabBar(
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          labelPadding: const EdgeInsets.only(left: 25, right: 25),
                          controller: _tabController,
                          labelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          overlayColor:
                              MaterialStateProperty.all(Colors.red[100]),
                          splashBorderRadius: BorderRadius.circular(50),
                          indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(50), // Creates border
                            color: Colors.red[400],
                          ),
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Text(
                              'All',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Popular',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Recommended',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            dragStartBehavior: DragStartBehavior.down,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 70),
                                child: ListView.builder(
                                    itemCount: places.length,
                                    itemBuilder: (context, index) {
                                      return PlaceTile(place: places[index]);
                                    }),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 70),
                                child: ListView.builder(
                                    itemCount: places.length,
                                    itemBuilder: (context, index) {
                                      if (places[index].popular) {
                                        return PlaceTile(place: places[index]);
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 70),
                                child: ListView.builder(
                                    itemCount: places.length,
                                    itemBuilder: (context, index) {
                                      if (places[index].recommended) {
                                        return PlaceTile(place: places[index]);
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
