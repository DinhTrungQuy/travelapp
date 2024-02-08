import 'package:flutter/material.dart';

class BookmarkButton extends StatelessWidget {
  final void Function() onTap;
  const BookmarkButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: Icon(
          Icons.bookmark,
          color: Colors.red[400],
        ),
        onPressed: onTap,
      ),
    );
  }
}
