import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'mex_events_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 300.0,
            child: Carousel(
              showIndicator: false,
              autoplayDuration: Duration(seconds: 4),
              images: [
                ExactAssetImage("assets/images/image_11.jpg"),
                ExactAssetImage("assets/images/radiobanner.jpg"),
                ExactAssetImage("assets/images/video.jpg"),
                ExactAssetImage("assets/images/image_30.jpg"),
              ],
            ),
          ),
          homeMenuItem(
              "Live TV", "assets/images/image_11.jpg", MexEvents(), context),
          homeMenuItem("Live Radio", "assets/images/radiobanner.jpg",
              MexEvents(), context),
          homeMenuItem(
              "CNews", "assets/images/image_30.jpg", MexEvents(), context),
          homeMenuItem(
              "Videos", "assets/images/video.jpg", MexEvents(), context),
          homeMenuItem(
              "Mex Events", "assets/images/image_11.jpg", MexEvents(), context),
        ],
      ),
      bottomNavigationBar: createBottomNav(),
    );
  }

  BottomNavigationBar createBottomNav() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            title: Text("Live Radio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("CNews"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            title: Text("Videos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Mex Events"),
          ),

        ]);
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
