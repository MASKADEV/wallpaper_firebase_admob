import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_code_source/home.dart';
import 'dart:io';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List animewallpaper = [];

  Future<void> getData() async {
    try {
      var result = await Firestore.instance
          .collection("wallpaper")
          .getDocuments()
          .then((QuerySnapshot snapshot) => snapshot.documents.forEach((f) {
                animewallpaper = f.data.values.toList();
                print(animewallpaper);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              animewallpaper: animewallpaper,
                            )));
              }));
    } on PlatformException {}
  }

  checkinternit() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Error()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkinternit();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )),
    );
  }
}

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "please check your internet connection and try again",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
