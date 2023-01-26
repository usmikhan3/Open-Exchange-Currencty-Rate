import 'dart:async';

import 'package:currency_rate/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({Key? key}) : super(key: key);

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  late InterstitialAd interstitialAd;
  var interstitialId = "ca-app-pub-3940256099942544/1033173712";

  bool isAdLoaded = true;

  initInterstitialAd() {
    InterstitialAd.load(

      adUnitId: interstitialId,
      request: AdRequest(),

      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad){
          interstitialAd = ad;
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: ((error){
          interstitialAd.dispose();
          print(error);
        }),

      ),

    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();

    Timer(const Duration(seconds: 2), (){
      interstitialAd.show();
    });

    Timer(const Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen(),),);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
