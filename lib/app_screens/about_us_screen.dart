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
                    color: Colors.pink,
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
                  "Last Update \nApril,2019",
                  style: TextStyle(color: Colors.black54, fontSize: 18.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 20.0),
                child: Text(
                  "MexTV is an online TV channel under INNOVILLE capital. "
                      "We seek to give platform to young talents to become their dreams and nurture their talents to make a success out of it.",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
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
