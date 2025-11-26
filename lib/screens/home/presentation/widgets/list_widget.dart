import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          "assets/Screenshot 2023-12-24 010215.png",
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
