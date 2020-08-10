import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:wallpaper_code_source/detailpage.dart';

const String testdevice = 'MobileId';

class Home extends StatefulWidget {
  List animewallpaper = [];
  Home({Key key, this.animewallpaper});
  @override
  _HomeState createState() => _HomeState(animewallpaper: animewallpaper);
}

class _HomeState extends State<Home> {
  List animewallpaper = [];
  _HomeState({Key key, this.animewallpaper});

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testdevice != null ? <String>[testdevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                      itemCount: animewallpaper.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width *
                              0.4 /
                              MediaQuery.of(context).size.height *
                              3),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => detailpage(
                                            animewallpaper:
                                                animewallpaper[index],
                                          )));
                              createInterstitialAd()
                                ..load()
                                ..show();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Stack(
                                children: [
                                  Center(child: CircularProgressIndicator()),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                animewallpaper[index]),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
            }),
      ),
    );
  }
}
