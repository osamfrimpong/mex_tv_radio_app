import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'all_radios_screen.dart';
import 'c_news_screen.dart';
import 'live_tv_screen.dart';
import 'mex_events_screen.dart';
import 'videos_screen.dart';
import 'package:mextv_app/models/models.dart';
import 'wp_news.dart';
//import 'package:mextv_app/app_screens/video_player.dart';
//import 'youtube_player_flutter.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Carouselimage> carouselImages = List();


  @override
  void initState() {
    super.initState();
    Carouselimage().select().toList((carouselimageList){
      this.setState(() {
        this.carouselImages = carouselimageList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 290.0,
          child: Carousel(
              showIndicator: false,
              autoplayDuration: Duration(seconds: 4),
              images: carouselImages.length > 0
                  ? carouselImages
                  .map((item) => CachedNetworkImageProvider(item.url))
                  .toList()
                  : [
                ExactAssetImage("assets/images/banner1.jpg"),
                ExactAssetImage("assets/images/banner2.jpg"),
                ExactAssetImage("assets/images/banner3.jpg"),
                ExactAssetImage("assets/images/banner4.jpg"),
                ExactAssetImage("assets/images/banner5.jpg"),
                ExactAssetImage("assets/images/banner6.jpg"),
              ]),
        ),
        homeMenuItem(
            "Live TV", "assets/images/livetv.jpeg", MyLiveTV(), context),
        homeMenuItem("Live Radio", "assets/images/radiobanner.jpg", AllRadiosScreen(),
            context),
        homeMenuItem("CNews", "assets/images/cnews.jpeg", MexNews(), context),
        homeMenuItem("Videos", "assets/images/video.jpg", Videos(), context),
        homeMenuItem(
            "Mex Events", "assets/images/mexevent.jpeg", MexEvents(), context),
      ],
    );
  }

  Widget homeMenuItem(
      String title, String image, navScreen, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => navScreen));
        },
        child: SizedBox(
          height: 100.0,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      image,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.6,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}