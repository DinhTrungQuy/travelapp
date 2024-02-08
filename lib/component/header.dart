import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void navigateToCart() {
    Navigator.pushNamed(context, '/addtocart');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.red[400],
            ),
          ),
          Text(
            'Travel App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red[400],
            ),
          ),
          GestureDetector(
            onTap: navigateToCart,
            child: Image.asset(
              'assets/images/default-user.png',
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
