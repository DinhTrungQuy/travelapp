// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WishlistButton extends StatelessWidget {
  final void Function() onTapToList;
  final void Function() onTapToRemove;
  final bool isWishlisted;
  const WishlistButton({
    Key? key,
    required this.onTapToList,
    required this.onTapToRemove,
    required this.isWishlisted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWishlisted
        ? Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red[400],
              ),
              onPressed: onTapToRemove,
            ),
          )
        : Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.red[400],
              ),
              onPressed: onTapToList,
            ),
          );
  }
}
