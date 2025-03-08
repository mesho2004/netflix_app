import 'package:flutter/material.dart';
import 'package:netflix_app/screens/fast_laughs/widgets/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
   ScreenFastLaugh({super.key});

  List reel = [
    "https://assets.mixkit.co/videos/1186/1186-720.mp4",
    "https://assets.mixkit.co/videos/1191/1191-720.mp4",
    "https://assets.mixkit.co/videos/1197/1197-720.mp4",
    "https://assets.mixkit.co/videos/1185/1185-720.mp4",
    "https://assets.mixkit.co/videos/1188/1188-720.mp4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PageView(
        scrollDirection: Axis.vertical,
        children:List.generate(reel.length, (index){
          return VideoListItem(index: index,link:reel[index]);
        }),
      ),
    ));
  }
}
