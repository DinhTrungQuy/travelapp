import 'package:flutter/material.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({super.key});

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
          Icons.favorite,
          color: Colors.red[400],
        ),
        onPressed: () {},
      ),
    );
  }
}