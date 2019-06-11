import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mextv_app/app_screens/about_us_screen.dart';
import 'package:share/share.dart';

//import 'package:mextv_app/app_screens/c_news_screen.dart';
import 'package:mextv_app/app_screens/live_tv_screen.dart';

//import 'package:mextv_app/app_screens/mex_contact_us_screen.dart';
import 'package:mextv_app/app_screens/schedule_screen.dart';


Drawer navDrawer(BuildContext context) {
  return new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            height: 200.0,
            child: new DrawerHeader(
              padding: new EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: Color(0xFF6A1061),
              ),
              child: new Center(
                child: Container(
                  width: 170.0,
                  height: 170.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/mex_tv_logo_small.png"),
                        fit: BoxFit.scaleDown,
                      ),
//                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      border: Border.all(color: Colors.black12, width: 4.0)),
                ),
              ),
            ),
          ),
          // new ListTile(
          //     leading: new Icon(Icons.play_arrow),
          //     title: new Text('Live TV'),
          //     onTap: () {
          //       Navigator.pop(context);
          //       doNavigation(context, LiveTV());
          //     }),
          new ListTile(
              leading: new Icon(Icons.access_time),
              title: new Text('Schedule'),
              onTap: () {
                Navigator.pop(context);
                doNavigation(context, Schedule());

              }),
//          new ListTile(
//              leading: new Icon(Icons.notifications_active),
//              title: new Text('Cnews'),
//              onTap: () {
//                Navigator.pop(context);
//                doNavigation(context, News());
//              }),
//          new ListTile(
//              leading: new Icon(Icons.calendar_today),
//              title: new Text('Mex Events'),
//              onTap: () {
//                Navigator.pop(context);
//                Navigator.of(context).pushNamed('/about');
//              }),
          new ListTile(
              leading: new Icon(Icons.free_breakfast),
              title: new Text('C Wine'),
              onTap: () {
                Navigator.pop(context);
                showSnackBar(context, "C Wine coming Soon!");
              }),
          new ListTile(
              leading: new Icon(Icons.fastfood),
              title: new Text('Fast Food'),
              onTap: () {
                Navigator.pop(context);
                showSnackBar(context, "Fast Food coming Soon!");
              }),
          new Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 17.0),
            child: Text("Application",style: TextStyle(color: Colors.black38),),
          ),
          new ListTile(
              leading: new Icon(Icons.star),
              title: new Text('Rate this app'),
              onTap: () {
                Navigator.pop(context);

              }),
          new ListTile(
              leading: new Icon(Icons.share),
              title: new Text('Share this App'),
              onTap: () {
                Navigator.pop(context);
                Share.share("Get our app from the play store or apple store");

              }),
          new ListTile(
              leading: new Icon(Icons.contact_mail),
              title: new Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
                showSnackBar(context, "Contact Us coming Soon!");
                //doNavigation(context, ContactUs());
              }),
          new ListTile(
              leading: new Icon(Icons.info),
              title: new Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                doNavigation(context, AboutUs());
              }),
          new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text('Exit'),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ));
}

void doNavigation(BuildContext context,whereToNavigateTo)
{
  Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => whereToNavigateTo));
}

void showSnackBar(BuildContext context,String message)
{
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
}