// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelapp/component/place_tile.dart';

import 'package:travelapp/model/place.dart';

class CategoryPage extends StatefulWidget {
  final List<Place> places;
  final int direction;
  const CategoryPage({
    Key? key,
    required this.places,
    required this.direction,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Place> _list = [];
  String directionText(int direction) {
    switch (direction) {
      case 0:
        return "Miền Bắc";
      case 1:
        return "Miền Trung";
      case 2:
        return "Miền Nam";
      default:
        return "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = widget.places
        .where((element) => element.direction == widget.direction)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(directionText(widget.direction)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: _list.length,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemBuilder: (context, index) {
          return PlaceTile(
            place: _list[index],
          );
        },
      ),
    );
  }
}
