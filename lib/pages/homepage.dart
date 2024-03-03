// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:travelapp/component/PlaceTile.dart';
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
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 25,
                      left: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Du lịch Việt Nam',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Khám phá vẻ đẹp tự nhiên và văn hóa của Việt Nam',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TabBar(
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            labelPadding: EdgeInsets.only(left: 0, right: 20),
                            controller: _tabController,
                            labelColor: Colors.red[400],
                            indicatorColor: Colors.red[400],
                            unselectedLabelColor: Colors.grey,
                            tabs: [
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            dragStartBehavior: DragStartBehavior.down,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 70),
                                child: ListView.builder(
                                    itemCount: places.length,
                                    itemBuilder: (context, index) {
                                      return PlaceTile(place: places[index]);
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 70),
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
                                margin: EdgeInsets.only(bottom: 70),
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
