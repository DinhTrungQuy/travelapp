import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  final void Function() onTap;
  const BackArrowButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
        ),
        onPressed: onTap,
      ),
    );
  }
}
