import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/model/place.dart';
import 'package:travelapp/pages/place-detail.dart';

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
      rating: '4.5',
      location: 'Quảng Ninh Province, Vietnam',
      price: 100,
    ),
    Place(
      name: 'Sapa',
      description:
          'Sa Pa is a town in the Hoàng Liên Son Mountains of northwestern Vietnam.',
      image: 'assets/images/places/sapa.jpg',
      rating: '3.0',
      location: 'Lào Cai Province, Vietnam',
      price: 150,
    ),
    Place(
      name: 'Hội An',
      description:
          'Hội An is a city on Vietnam’s central coast known for its well-preserved Ancient Town.',
      image: 'assets/images/places/hoian.jpg',
      rating: '5.0',
      location: 'Quảng Nam Province, Vietnam',
      price: 200,
    ),
    Place(
      name: 'Phú Quốc',
      description:
          'Phú Quốc is a Vietnamese island off the coast of Cambodia in the Gulf of Thailand.',
      image: 'assets/images/places/phuquoc.jpg',
      rating: '2.5',
      location: 'Kiên Giang Province, Vietnam',
      price: 250,
    ),
  ];
  void navigateToPalaceDetail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetail(
          place: places[index],
        ),
      ),
    );
  }

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
          // Header(),
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
                                return GestureDetector(
                                  onTap: () {
                                    navigateToPalaceDetail(index);
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
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
                                                  Text(
                                                    '\$${places[index].price} / người',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
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
