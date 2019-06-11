import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import '../models/models.dart';
// import 'package:youtube_player/youtube_player.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {

  List<Youtubevideo> youtubeVideoList = new List();
  int itemLength = 0;

  @override
  void initState() {
    super.initState();
    Youtubevideo().select().toList((youtubevideos) {
      this.setState(() {
        this.youtubeVideoList = youtubevideos;
        this.itemLength = youtubeVideoList.length;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: MexAppBar.create("Videos"),
      body: Container(child: Center(child: Text(itemLength.toString()),),),
    );
  }
}
