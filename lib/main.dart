import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'app_screens/mex_events_screen.dart';
import 'app_screens/c_news_screen.dart';
import 'app_screens/live_radio_screen.dart';
import 'app_screens/live_tv_screen.dart';
import 'app_screens/videos_screen.dart';
import 'components/mex_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'components/navigation_drawer.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
    theme: ThemeData(
      fontFamily: "Ebrima",
      primaryColor: Colors.pink,
      primaryColorDark: Colors.pink,
    ),
  ));
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with AutomaticKeepAliveClientMixin<WelcomeScreen> {
  int _selectedIndex = 0;
  final bodyScreens = [Home(), LiveRadio(), News(), Videos(), MexEvents()];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _selectedIndex == 0 ? MexAppBar.create("Home") : null,
      body: bodyScreens[_selectedIndex],
      bottomNavigationBar: createBottomNav(),
      drawer: _selectedIndex == 0 ? navDrawer(context) : null,
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
            icon: Icon(Icons.tap_and_play),
            title: Text("Live Radio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text("CNews"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            title: Text("Videos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Mex Events"),
          ),
        ]);
  }

  //Navigation Drawer




  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 290.0,
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
            "Live TV", "assets/images/livetv.jpeg", LiveTV(), context),
        homeMenuItem("Live Radio", "assets/images/radiobanner.jpg",LiveRadio(),
            context),
        homeMenuItem("CNews", "assets/images/cnews.jpeg", News(), context),
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
