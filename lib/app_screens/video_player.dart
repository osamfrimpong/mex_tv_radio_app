import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class MyVideoPlayer extends StatefulWidget {
//  final Youtubevideo youtubevideo;
//
//  MyVideoPlayer({Key key, @required this.youtubevideo}) : super(key: key);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  var youtube = FlutterYoutube();

  @override
  initState() {
    super.initState();
  }

  // void playVideo(){

  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MexAppBar.create("Live TV"),
        body: Container(
          child: IconButton(
            onPressed: () {
              FlutterYoutube.playYoutubeVideoById(
                  videoId: "IplzyyspOh4",
                  apiKey: "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY",
                  autoPlay: true);
            },
            icon: Icon(Icons.play_arrow),
          ),
        ),
      ),
    );
  }
}
