import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import 'package:youtube_api/youtube_api.dart';
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
  bool  isLoading = false;

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
        child: youtubeVideosList.length > 0
            ? ListView.builder(
                itemCount: youtubeVideosList.length,
                itemBuilder: (_, int index) => listItem(index))
            : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.cloud_off,color: Theme.of(context).primaryColor,size: 54.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No Data!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
              ),
             Text(isLoading?"Loading...":"Please Reload",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54,fontSize: 18.0),),
            ],
          )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // debugPrint(_tabController.index.toString());
            setState(() {
              isLoading = true;
            });
          loadYoutubeVideos();
        
        },
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
      },
    );
  }

loadYoutubeVideos() async {
  const String key = "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY";
  const String channelId = "UCc1HrPSJ7fKTKi7Uol5dQ1A";
  List<Youtubevideo> videoListForDb = new List();

  YoutubeAPI ytApi = new YoutubeAPI(key, type: "channel");
  List<YT_API> ytResult = [];

  ytResult = await ytApi.channel(channelId);
  int id = 1;
  //save to database
  for (var ytVideo in ytResult) {
    Youtubevideo videoItem = Youtubevideo(
        id: id++,
        video_title: ytVideo.title,
        thumbnail: ytVideo.thumbnail['default']['url'],
        video_url: ytVideo.url,
        video_id: ytVideo.id);
    videoListForDb.add(videoItem);
  }
  if (videoListForDb.length > 0) {
    Youtubevideo().saveAll(videoListForDb).then((results) {
      Future.delayed(Duration(seconds: 4)).then((onValue){
                setState(() {
                  youtubeVideosList = videoListForDb;
                  isLoading = false;
                });
              });
    });
  }
}

}
