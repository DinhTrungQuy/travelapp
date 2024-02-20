import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelapp/component/add-to-cart-bar.dart';
import 'package:travelapp/component/back-button.dart';
import 'package:travelapp/component/bookmark-button.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 71,
        leading: Container(
          margin: EdgeInsets.only(left: 15),
          child: BackArrowButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: BookmarkButton(
              onTap: () async {
                //TODO: async bookmark
                print('Bookmark Button');
              },
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  widget.place.image,
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
                bottom: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
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
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.place.rating,
                            style: TextStyle(
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
                        tabs: [
                          Tab(
                            icon: Icon(Icons.info_outline),
                            text: 'About',
                          ),
                          Tab(
                            icon: Icon(Icons.photo),
                            text: 'Photos',
                          ),
                          Tab(
                            icon: Icon(Icons.map),
                            text: 'Map',
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: size.height * 0.3,
                        child: Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: const TextStyle(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Photos',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          widget.place.image,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Image.asset(
                                          widget.place.image,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Map',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Image.asset(
                                  //   'assets/images/map.png',
                                  //   height: 200,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ],
                              ),
                            ],
                          ),
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
            child: AddToCartBar(price: widget.place.price.toString()),
          ),
        ],
      ),
    );
  }
}
