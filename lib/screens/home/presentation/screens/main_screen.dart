import 'package:flutter/material.dart';
import 'package:netflix_clonee/screens/download_screen.dart';
import 'package:netflix_clonee/screens/fast_laughs/screen_fast_laugh.dart';
import 'package:netflix_clonee/screens/home/presentation/screens/home_screen.dart';
import 'package:netflix_clonee/screens/home/presentation/widgets/bottom_nav.dart';
import 'package:netflix_clonee/screens/more_screen.dart';
import 'package:netflix_clonee/screens/new_and_hot_screen/new_and_hot_scrn.dart';
import 'package:netflix_clonee/screens/search/search_screen.dart';
import 'package:netflix_clonee/screens/all%20details/all%20details%20screens/my_list_screen.dart';
import 'package:netflix_clonee/screens/users%20screen/user_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final pages = [
    HomeScreen(),
    SearchScreen(),
    NewAndHotScrn(),
    ScreenFastLaugh(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int index, _) {
          return pages[index];
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
