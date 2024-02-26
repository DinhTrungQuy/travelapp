import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:travelapp/component/CustomSearchBar.dart';
import 'package:travelapp/component/PlaceCategoryTile.dart';
import 'package:travelapp/component/PlaceTile.dart';
import 'package:travelapp/model/place.dart';

const String manLookRightImageUrl =
    'https://flutter-ui.s3.us-east-2.amazonaws.com/ecommerce/man-look-right.jpg';
const String dogImageUrl =
    'https://flutter-ui.s3.us-east-2.amazonaws.com/ecommerce/pet.jpg';
const String womanLookLeftImageUrl =
    'https://flutter-ui.s3.us-east-2.amazonaws.com/ecommerce/woman-look-left.jpg';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String searchString;
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
    // TODO: implement initState
    super.initState();
    fetchPlaces().then((value) => setState(() {
          places = value;
          loading = false;
        }));
    searchString = "";
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
        actions: [],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                        Text(
                          'Shop by Category',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        PlaceCategoryTile(
                          title: "Miền Bắc",
                          imageUrl: "https://quydt.speak.vn/image/mien_bac.jpg",
                          place: places[0],
                          imageAlignment: Alignment.topCenter,
                        ),
                        SizedBox(height: 16),
                        PlaceCategoryTile(
                          title: "Miền Trung",
                          imageUrl:
                              "https://quydt.speak.vn/image/mien_trung.jpg",
                          place: places[1],
                          imageAlignment: Alignment.topCenter,
                        ),
                        SizedBox(height: 16),
                        PlaceCategoryTile(
                          title: "Miền Nam",
                          imageUrl: "https://quydt.speak.vn/image/mien_nam.jpg",
                          place: places[2],
                        ),
                        SizedBox(height: 65),
                      ],
                    ),
            ),
    );
  }
}
