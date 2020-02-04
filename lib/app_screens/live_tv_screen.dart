import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
//import 'package:youtube_player/youtube_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_youtube/flutter_youtube.dart';

class MyLiveTV extends StatefulWidget {
  @override
  _MyLiveTVState createState() => _MyLiveTVState();
}

class _MyLiveTVState extends State<MyLiveTV> {
  String youtubeStreamLink = "Dv7kcoqSopE";
  bool isStreaming = false;
  bool isStreamingLive = false;

  // YoutubePlayerController _controller = YoutubePlayerController();

  @override
  void initState() {
    super.initState();
    retrieveChannelData("live").then((data) {
      int totalLiveVideos = data['pageInfo']['totalResults'];
      if (totalLiveVideos > 0) {
        setState(() {
          youtubeStreamLink = data['items'][0]['id']['videoId'];
          isStreamingLive = true;
        });
      } else {
        retrieveChannelData("completed").then((videoData) {
          int totalCompletedVideos = videoData['pageInfo']['totalResults'];
          if (totalCompletedVideos > 0) {
            setState(() {
              youtubeStreamLink = videoData['items']
                  [0]['id']['videoId'];
              isStreaming = true;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("Live TV"),
      body:
          Container(
            child:
                (isStreamingLive || isStreaming)
                    ? _flutterYoutube(youtubeStreamLink)
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: CircularProgressIndicator(),
                            title: Text("Getting Live Stream!"),
                          ),
                        ),
                      ),
//            Center(
//              child: (!isStreaming && isStreamingLive)
//                  ? Text("We are Live!")
//                  : Text("We are Currently not streaming live."
//                      "\However, You can enjoy some random picks "
//                      "from our previous Live Streams. Thank you"),
//            ),
          ),


    );
  }

  Future retrieveChannelData(String eventType) async {
    const String key = "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY";
    const String channelId = "UC6o7LBXUoqdeWP4ScFvKtbg";
    String url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channelId&eventType=$eventType&type=video&key=$key";

    var response = await http.get(url);
    print("$eventType Video Results: ${jsonDecode(response.body)}");
    return jsonDecode(response.body);
  }

//   Widget _youtubePlayerFlutter(String videoLink) {
//     return YoutubePlayer(
//       context: context,
//       videoId: videoLink,
//       flags: YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//         forceHideAnnotation: true,
//         showVideoProgressIndicator: true,
//       ),
//       videoProgressIndicatorColor: Colors.amber,
//       progressColors: ProgressColors(
//         playedColor: Colors.amber,
//         handleColor: Colors.amberAccent,
//       ),
//       onPlayerInitialized: (controller) {
//         _controller = controller;
// //            _controller.addListener(listener);
//       },
//     );
//   }

  Widget _flutterYoutube(String videoLink) {
//    FlutterYoutube.playYoutubeVideoById(
//        videoId: videoLink,
//        apiKey: "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY",
//        autoPlay: true);
    return Container(
      color: Colors.black,
      height: 200.0,
      child: Center(
        child: IconButton(
          icon: Icon(Icons.play_circle_filled,color: Colors.white,size: 50.0,),
          onPressed: () {
            FlutterYoutube.playYoutubeVideoById(
                videoId: videoLink,
                apiKey: "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY",
                autoPlay: true);
          },

        ),
      ),
    );
  }
}

//Widget _youtubePlayer(String videoLink){
//  YoutubePlayer(
//    context: context,
//    source: videoLink,
//    quality: YoutubeQuality.HD,
//    isLive: true,
//    aspectRatio: 16 / 9,
//    autoPlay: true,
//    loop: false,
//    reactToOrientationChange: true,
//    startFullScreen: false,
//    controlsActiveBackgroundOverlay: true,
//    controlsTimeOut: Duration(seconds: 4),
//    playerMode: YoutubePlayerMode.DEFAULT,
//    showThumbnail: true,
//    keepScreenOn: true,
//  )
//}
