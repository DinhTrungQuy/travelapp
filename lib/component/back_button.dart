import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  final void Function() onTap;
  const BackArrowButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.red[400],
        ),
        onPressed: onTap,
      ),
    );
  }
}
