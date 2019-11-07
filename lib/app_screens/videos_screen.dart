import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import '../models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  List<Youtubevideo> youtubeVideosList = List();
  int itemLength = 0;

  @override
  void initState() {
    
    Youtubevideo().select().toList((youtubevideoList) {
      setState(() {
        youtubeVideosList = youtubevideoList;
        itemLength = youtubevideoList.length;
      });
    });
   super.initState();
  }

_launchURL(String url) async {
  // const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("Videos"),
      // body: Container(child: Center(child: Text("videoList.length.toString()"),),),
      body: Container(
        child: itemLength > 0
            ? ListView.builder(
                itemCount: youtubeVideosList.length,
                itemBuilder: (_, int index) => listItem(index))
            : Center(
                child: Text(
                  "No Videos!\nCheck Internet and Restart App",
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }

  Widget listItem(index) {
    return InkWell(
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: youtubeVideosList[index].thumbnail,
              ),
              Padding(padding: EdgeInsets.only(right: 20.0)),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text(
                      youtubeVideosList[index].video_title,
                      softWrap: true,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ]))
            ],
          ),
        ),
      ),
      onTap: () {
        _launchURL("https://youtube.com/watch?v="+youtubeVideosList[index].video_id);
        // print("url: "+youtubeVideosList[index].video_url);
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (BuildContext context) => MyYoutubePlayer(
        //         youtubevideo: youtubeVideosList[index],
        //       ),
        // ));
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (BuildContext context) => MyHomePage(
        //         title: youtubeVideosList[index].video_title,
        //         videoId: youtubeVideosList[index].video_id,
        //       ),
        // ));
      },
    );
  }
}
