import 'package:flutter/material.dart';
import 'package:mextv_app/app_screens/videos_screen.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import 'package:mextv_app/components/navigation_drawer.dart';
import 'all_radios_screen.dart';
import 'c_news_screen.dart';
import 'home_screen.dart';
import 'mex_events_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with AutomaticKeepAliveClientMixin<WelcomeScreen> {
  int _selectedIndex = 0;
  final bodyScreens = [Home(), AllRadiosScreen(), News(), Videos(), MexEvents()];

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
