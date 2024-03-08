// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelapp/model/Place.dart';

class CategoryPage extends StatefulWidget {
  final Place place;
  const CategoryPage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Center(
        child: Text("Category Page"),
      ),
    );
  }
}
