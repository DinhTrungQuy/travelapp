import 'package:flutter/material.dart';
import 'package:travelapp/model/Place.dart';
import 'package:travelapp/pages/CategoryPage.dart';

class PlaceCategoryTile extends StatelessWidget {
  final String imageUrl;
  final Place place;
  final String title;
  const PlaceCategoryTile(
      {required this.place,
      required this.imageUrl,
      required this.title,
      this.imageAlignment = Alignment.center,
      Key? key})
      : super(key: key);

  /// Which part of the image to prefer
  final Alignment imageAlignment;
  void _pushScreen({required BuildContext context, required Widget screen}) {
    ThemeData themeData = Theme.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Theme(data: themeData, child: screen),
      ),
    );
  }

  String directionConvert(int dir) {
    if (dir == 0) return "Miền Bắc";
    if (dir == 1) return "Miền Trung";
    if (dir == 2) return "Miền Nam";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          _pushScreen(context: context, screen: CategoryPage(place: place)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
              alignment: imageAlignment,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
