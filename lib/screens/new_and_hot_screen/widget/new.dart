import 'package:flutter/material.dart';

class SelectOptionsWidget extends StatelessWidget {
  final String title;
  const SelectOptionsWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
        ),
        onPressed: () {},
        child:  Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
