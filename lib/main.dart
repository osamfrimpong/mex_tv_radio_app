import 'package:flutter/material.dart';
import 'app_screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'db/MyDbModel.dart';
import 'models/models.dart';


void main() {

  MyDbModel().initializeDB((result) {
    if (result == true) {
      loadLiveRadio();
      loadCarouselImages();
      loadYoutubeVideos();
      runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        theme: ThemeData(
          fontFamily: "Ebrima",
          primaryColor: Color(0xFF6A1061),
          primaryColorDark: Color(0xFF6A1061),
        ),
      ));
    }
  });


}

loadLiveRadio(){
            Liveradio.fromWeb((liveradioList){
            Liveradio().saveAll(liveradioList).then((results){
//              for (var result in results)
               print(results.toString());
            });
          });
}

loadCarouselImages(){
  Carouselimage.fromWeb((carouselimageList){
    Carouselimage().saveAll(carouselimageList).then((results){
               print(results.toString());
    });
  });
}

loadYoutubeVideos(){
  Youtubevideo.fromWeb((youtubevideoList){
    Youtubevideo().saveAll(youtubevideoList).then((results){
        print(results.toString());
    });
  });
}



