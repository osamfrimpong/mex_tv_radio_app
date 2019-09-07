import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MexAppBar.create("About Us"),
        body: SingleChildScrollView(
          reverse: false,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                child: Text(
                  "MexTV + Radio",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 5.0, left: 10.0, bottom: 20.0),
                child: SizedBox(
                  width: 180.0,
                  height: 3.0,
                  child: Container(
                    color: Color(0xFF6A1061),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 20.0),
                child: Text(
                  "Version\n2.2.1",
                  style: TextStyle(color: Colors.black54, fontSize: 18.0),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 20.0),
                child: Text(
                  "Last Update \nSeptember,2019",
                  style: TextStyle(color: Colors.black54, fontSize: 18.0),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 20.0),
                child: Text(
                  "Mex Tv/ Radio is a Christian educational television and Radio with content related to youth's and views about education entertainment, society, Christianity, politics, science, and technology to students, faculty members, and everyone who has access to the Internet. It is a part of MEX studios Global. "
                      "\n\nVision: To be the first Online TV/Radio option for young people and middle aged adults in Ghana, Africa and beyond and to also to give them a different point of view. "
                      "\n\nMission: Media Excellence Television and Radio seeks to provide high-quality, Christian, entertaining, educational, inspirational programmes and broadcasting across the globe that will provide platforms for businesses, individuals and non-profit organizations in promoting their brands and reaching out to a wide range of potential customers. We want to also to be the trusted source of informative, educational and entertaining content in every field.",
                  style: TextStyle(color: Colors.black, fontSize: 20.0,),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 20.0, left: 10.0, bottom: 20.0),
                child: Text(
                  "Developer:\n Osam-Frimpong Schandorf\n+233547289638\n"
                      "osamfrimpong@gmail.com\nFacebook/Twitter/Github:\n@osamfrimpong",
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ));
  }
}
