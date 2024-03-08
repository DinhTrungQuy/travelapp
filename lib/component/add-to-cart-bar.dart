import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/component/mybutton.dart';
import 'package:travelapp/model/Place.dart';
import 'package:travelapp/pages/BookingPage.dart';

class AddToCartBar extends StatefulWidget {
  final Place place;
  const AddToCartBar({super.key, required this.place});

  @override
  State<AddToCartBar> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends State<AddToCartBar> {
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content:
        Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      TextButton(
        child: Text("Yes"),
        onPressed: () {
          print("You choose Yes");
        },
      ),
      TextButton(
        child: Text("No"),
        onPressed: () {
          print("You choose No");
        },
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: ${widget.place.price} \$',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          MyButton(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              if (prefs.getString('token') == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "You need to login first.",
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Colors.red[400],
                  ),
                );
              } else
                //TODO: Add to cart function
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookingPage(place: widget.place)));
              print('Book now Button');
            },
            title: 'Book now',
          ),
        ],
      ),
    );
  }
}
