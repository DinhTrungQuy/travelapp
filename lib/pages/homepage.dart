import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/component/header.dart';
import 'package:travelapp/model/place.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Place> places = [
    Place(
      name: 'Hạ Long Bay',
      description:
          'Hạ Long Bay is a UNESCO World Heritage Site and popular travel destination in Quảng Ninh Province, Vietnam.',
      image: 'assets/images/places/halongbay.jpg',
      rating: '4.9',
      location: 'Quảng Ninh Province, Vietnam',
      price: '100',
    ),
    Place(
      name: 'Sapa',
      description:
          'Sa Pa is a town in the Hoàng Liên Son Mountains of northwestern Vietnam.',
      image: 'assets/images/places/sapa.jpg',
      rating: '4.8',
      location: 'Lào Cai Province, Vietnam',
      price: '150',
    ),
    Place(
      name: 'Hội An',
      description:
          'Hội An is a city on Vietnam’s central coast known for its well-preserved Ancient Town.',
      image: 'assets/images/places/hoian.jpg',
      rating: '4.7',
      location: 'Quảng Nam Province, Vietnam',
      price: '200',
    ),
    Place(
      name: 'Phú Quốc',
      description:
          'Phú Quốc is a Vietnamese island off the coast of Cambodia in the Gulf of Thailand.',
      image: 'assets/images/places/phuquoc.jpg',
      rating: '4.6',
      location: 'Kiên Giang Province, Vietnam',
      price: '250',
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
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
                          'Tất cả',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Nổi bật',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Yêu thích',
                          style: TextStyle(
                            fontSize: 14,
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
                      controller: _tabController,
                      dragStartBehavior: DragStartBehavior.down,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 70),
                          child: ListView.builder(
                              itemCount: places.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(places[index].name);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            places[index].image,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                places[index].name,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                child: Text(
                                                  places[index].description,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.red[400],
                                                  ),
                                                  Text(
                                                    places[index].location,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.red[400],
                                                  ),
                                                  Text(
                                                    places[index].rating,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '\$${places[index].price} / người',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Text('Nổi bật List'),
                        Text('Yêu thích List'),
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