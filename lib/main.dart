import 'package:flutter/material.dart';
import 'app_screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'db/MyDbModel.dart';
import 'helpers/data_loading.dart';

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


