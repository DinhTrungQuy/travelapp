import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:travelapp/component/custom_search_bar.dart';
import 'package:travelapp/component/place_category_tile.dart';
import 'package:travelapp/component/place_tile.dart';
import 'package:travelapp/model/login_status.dart';
import 'package:travelapp/model/place.dart';

import 'package:travelapp/pages/login_page.dart';

class SearchPage extends StatefulWidget {
  final String token;

  const SearchPage({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Place> places = [];
  bool loading = true;
  String searchString = "";
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
    // TODO: implement initState
    super.initState();
    fetchPlaces().then((value) => setState(() {
          places = value;
          loading = false;
        }));
  }

  void setSearchString(String value) => setState(() {
        searchString = value;
      });
  String removeDiacritics(String str) {
    var withDiacritics =
        'áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđ';
    var withoutDiacritics =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd';

    for (int i = 0; i < withDiacritics.length; i++) {
      str = str.replaceAll(withDiacritics[i], withoutDiacritics[i]);
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {
    final loginStatus = Provider.of<LoginStatus>(context);
    List<Place> searchResultTiles = [];
    if (searchString.isNotEmpty) {
      searchResultTiles = places
          .where((place) =>
              place.name.toLowerCase().contains(searchString.toLowerCase()) |
              removeDiacritics(place.name)
                  .toLowerCase()
                  .contains(removeDiacritics(searchString.toLowerCase())))
          .toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: CustomSearchBar(
          onChanged: setSearchString,
        ),
        scrolledUnderElevation: 0,
        actions: const [],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : loginStatus.isLoggedIn
              ? Container(
                  margin: const EdgeInsets.all(16),
                  child: searchString.isNotEmpty
                      ? ListView.builder(
                          itemCount: searchResultTiles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PlaceTile(
                              place: searchResultTiles[index],
                            );
                          })
                      : ListView(
                          padding: const EdgeInsets.all(0),
                          children: [
                            const Text(
                              'Tours by region',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 16),
                            PlaceCategoryTile(
                              direction: 0,
                              title: "Miền Bắc",
                              imageUrl:
                                  "https://quydt.speak.vn/images/mien_bac.jpg",
                              places: places,
                              imageAlignment: Alignment.topCenter,
                            ),
                            const SizedBox(height: 16),
                            PlaceCategoryTile(
                              direction: 1,
                              title: "Miền Trung",
                              imageUrl:
                                  "https://quydt.speak.vn/images/mien_trung.jpg",
                              places: places,
                              imageAlignment: Alignment.topCenter,
                            ),
                            const SizedBox(height: 16),
                            PlaceCategoryTile(
                              direction: 2,
                              title: "Miền Nam",
                              imageUrl:
                                  "https://quydt.speak.vn/images/mien_nam.jpg",
                              places: places,
                            ),
                            const SizedBox(height: 65),
                          ],
                        ),
                )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You need to login first.'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text('Login'),
                    ),
                  ],
                )),
    );
  }
}
