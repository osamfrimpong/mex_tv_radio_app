import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';


class LiveTV extends StatefulWidget {
  @override
  _LiveTVState createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("Live TV"),
      body: Container(child: Center(child: Text("Live TV Coming Soon!"),),),
    );
  }
}
