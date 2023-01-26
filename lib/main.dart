import 'package:currency_rate/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
 await  MobileAds.instance.initialize();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exchange Rates',
      theme: ThemeData(
        fontFamily: 'DMSans',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

