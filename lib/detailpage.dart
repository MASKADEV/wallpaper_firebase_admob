import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class detailpage extends StatefulWidget {
  String animewallpaper;
  detailpage({Key key, this.animewallpaper});
  @override
  _detailpageState createState() =>
      _detailpageState(animewallpaper: animewallpaper);
}

class _detailpageState extends State<detailpage> {
  String animewallpaper;
  String _wallpaperFile = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> setWallpaperFromFile() async {
    setState(() {
      _wallpaperFile = "Loading";
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(animewallpaper);

    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    if (!mounted) return;

    setState(() {
      _wallpaperFile = result;
    });
  }

  _detailpageState({Key key, this.animewallpaper});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      animewallpaper,
                      fit: BoxFit.fill,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setWallpaperFromFile(),
                    child: Align(
                      alignment: Alignment(0, 0.6),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent.withOpacity(0.6),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Set wallpaper",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'Wallpaper status: $_wallpaperFile\n',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment(0.9, -0.9),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ))
                ],
              );
            }));
  }
}
