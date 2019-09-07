import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import 'package:youtube_player/youtube_player.dart';
import 'package:http/http.dart' as http;


class LiveTV extends StatefulWidget {
  @override
  _LiveTVState createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  String youtubeStreamLink = "q2KiwKlG85s";
  bool isStreaming = false;


  @override
  void initState() {
    super.initState();
    retrieveChannelData().then((data) {
      int totalVideos = data['pageInfo']['totalResults'];
      if (totalVideos > 0) {
        setState(() {
          youtubeStreamLink = data['items'][0]['id']['videoId'];
          isStreaming = true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("Live TV"),
      body: Container(
        child: isStreaming ? YoutubePlayer(
          context: context,
          source: youtubeStreamLink,
          quality: YoutubeQuality.HD,
          isLive: true,
          aspectRatio: 16 / 9,
          autoPlay: true,
          loop: false,
          reactToOrientationChange: true,
          startFullScreen: false,
          controlsActiveBackgroundOverlay: true,
          controlsTimeOut: Duration(seconds: 4),
          playerMode: YoutubePlayerMode.DEFAULT,
          showThumbnail: true,
          keepScreenOn: true,
        ) : Center(child: Text("We're Currently Not Streaming Live"),),
      ),
    );
  }


  Future retrieveChannelData() async {
    const String key = "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY";
    const String channelId = "UCc1HrPSJ7fKTKi7Uol5dQ1A";
    String url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=${channelId}&eventType=live&type=video&key=${key}";

    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}
