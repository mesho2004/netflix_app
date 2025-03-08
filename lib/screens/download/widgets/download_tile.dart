import 'package:flutter/material.dart';

class DownloadTitle extends StatelessWidget {
  const DownloadTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
        Text('Smart Downloads')
      ],
    );
  }
}
