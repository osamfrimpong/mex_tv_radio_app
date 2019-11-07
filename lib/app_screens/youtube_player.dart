import 'package:flutter/material.dart';
//import 'package:youtube_player/youtube_player.dart';
import 'package:mextv_app/models/models.dart';
import 'package:mextv_app/components/mex_app_bar.dart';

class MyYoutubePlayer extends StatefulWidget {
  final Youtubevideo youtubevideo;

  MyYoutubePlayer({Key key, @required this.youtubevideo}) : super(key: key);

  @override
  _MyYoutubePlayerState createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create(widget.youtubevideo.video_title),
          body: Container(
        child: Text("YOutube"),
      ),
    );
  }
}
