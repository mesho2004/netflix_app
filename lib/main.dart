import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/screens/splash/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
//  try{
//   await Firebase.initializeApp();
// }  catch(e){
//   print("error $e");
// }
await Supabase.initialize(
  url: 'https://stxsfhwrtdwfiyqurfsv.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN0eHNmaHdydGR3Zml5cXVyZnN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ3Mzc3ODQsImV4cCI6MjA3MDMxMzc4NH0.8rvvJ5RyBBxqBSx7qiDhhBZJ3LLpuzXAfxOBrQdIJ0E'
  
  
  

);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      
    );
  }
}
