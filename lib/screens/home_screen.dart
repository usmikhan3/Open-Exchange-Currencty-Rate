import 'dart:async';

import 'package:currency_rate/model/rates_model.dart';
import 'package:currency_rate/services/api_services.dart';
import 'package:currency_rate/widgets/any_to_any.dart';
import 'package:currency_rate/widgets/usd_to_any.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  late Future<Map> allCurrencies;
  late Future<RatesModel> result;
  final formKey = GlobalKey<FormState>();

  //TODO: BANNER AD
  late BannerAd bannerAd;
  var adUnitId = "ca-app-pub-3940256099942544/6300978111"; //testADID
  bool isAdLoaded = false;
  initBannerAd() async {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad){
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad,error){
          ad.dispose();
          print(error);
        },


      ),
      request: AdRequest(

      ),
    );

    bannerAd.load();
  }

  //TODO: INTERSTITIAL AD
  late InterstitialAd interstitialAd;
  var interstitialId = "ca-app-pub-3940256099942544/1033173712";

  bool isAdInterstitialLoaded = true;

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

    setState(() {
      result = APIServices.fetchRates();
      allCurrencies = APIServices.fetchCurrencies();
    });

    initBannerAd();
    initInterstitialAd();

    Timer(const Duration(seconds: 2), (){
      interstitialAd.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.black
              /* image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),*/
              ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Open ",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Exchange ",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Rates",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFECE115),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Spacer(),
                Form(
                  key: formKey,
                  child: FutureBuilder<RatesModel>(
                    future: result,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Center(
                        child: FutureBuilder<Map>(
                          future: allCurrencies,
                          builder: (context, currSnapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    UsdToAny(
                                      currencies: currSnapshot.data ?? {},
                                      rates: snapshot.data!.rates,
                                    ),
                                    AnyToAny(
                                      currencies: currSnapshot.data ?? {},
                                      rates: snapshot.data!.rates,
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                Spacer(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Created by: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Softnox Tecnologies",
                      style: TextStyle(
                        color: Color(0xFFECE115),
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: isAdLoaded ? SizedBox(
        height: bannerAd.size.height.toDouble(),
        width: bannerAd.size.width.toDouble(),
        child: AdWidget(ad: bannerAd,),
      ) :const  SizedBox(),
    );
  }
}
