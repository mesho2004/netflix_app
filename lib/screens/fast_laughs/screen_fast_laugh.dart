import 'package:flutter/material.dart';
import 'package:netflix_app/screens/fast_laughs/widgets/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
   ScreenFastLaugh({super.key});

  List reel = [
    'assets/white.mp4',
    'assets/videoplayback.mp4'
    
    
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
