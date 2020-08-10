import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpaper_code_source/home.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List animewallpaper = [];

  Future<void> getData() async {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
