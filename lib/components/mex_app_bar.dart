import 'package:flutter/material.dart';

class MexAppBar{

  static AppBar create(String title)
  {
    return AppBar(title: Text(title),centerTitle: true,elevation: 0.0,);
  }
}