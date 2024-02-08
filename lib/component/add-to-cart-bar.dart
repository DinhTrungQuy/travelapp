import 'package:flutter/material.dart';
import 'package:travelapp/component/mybutton.dart';

class AddToCartBar extends StatefulWidget {
  final String price;
  const AddToCartBar({super.key, required this.price});

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
            'Total: ${widget.price} \$',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          MyButton(
            onTap: () {
              //TODO: Add to cart function
              print('Book now Button');
            },
            title: 'Book now',
          ),
        ],
      ),
    );
  }
}
