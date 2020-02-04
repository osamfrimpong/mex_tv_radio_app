import 'package:flutter/material.dart';
import 'app_screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'db/MyDbModel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MyDbModel().initializeDB((result) {
    if (result == true) {
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


