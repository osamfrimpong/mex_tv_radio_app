import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("Videos"),
      body: Container(child: Center(child: Text("Videos"),),),
    );
  }
}
