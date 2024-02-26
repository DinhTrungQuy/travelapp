import 'package:flutter/material.dart';
import 'package:travelapp/component/mybutton.dart';
import 'package:travelapp/model/place.dart';
import 'package:travelapp/pages/BookingPage.dart';

class AddToCartBar extends StatefulWidget {
  final Place place;
  const AddToCartBar({super.key, required this.place});

  @override
  State<AddToCartBar> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends State<AddToCartBar> {
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
            onTap: () {
              //TODO: Add to cart function
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingPage(place: widget.place)));
              print('Book now Button');
            },
            title: 'Book now',
          ),
        ],
      ),
    );
  }
}
