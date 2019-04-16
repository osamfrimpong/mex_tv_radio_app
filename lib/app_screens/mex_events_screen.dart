import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MexEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 250.00,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: Image.asset(
                  "assets/images/image_11.jpg",
                  fit: BoxFit.cover,
                ),
                title: Container(child: Text("Mex Events")),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: <Widget>[
              renderTexts("Event Lighting",
                  "At Mex Event, we specialize in transforming event spaces with lighting, we can take any space from basic to breathtaking. By understanding the client’s vision and applying our expertise, we will create a beautiful design that will add the WOW Factor, one that creates a feeling of completeness between the overall decor and event space—a total room transformation. We offer unique and affordable lighting for weddings, private parties, special occasions, corporate functions, fundraisers and concerts etc."),
              renderTexts(
                  "Videography of events", "We offer excellent videography"),
              renderTexts("Streaming services",
                  "Not everyone can attend an event or conference in person, but live-streaming, allows the material to reach a worldwide audience, who can watch in real-time.    We are adept at streaming conferences, panels, QAs, seminars, and launch parties.  We can stream a single feed from your event to our servers which can then be put out to unlimited destinations online, for example simultaneously to Facebook, YouTube, Periscope, Twitch, your own servers, as well as a custom embeddable player with your own logo and colour scheme. We automatically take an online backup of the stream which is available as video-on-demand 10 minutes after the stream has ended. The video file can be replaced if there are any edits required.  We also have the ability to have auto updating Twitter feeds or administered Twitter feeds overlaid onto videos based on specific hashtags or user accounts for real-time interaction with viewers, and a full chat window available to be embedded with the stream!"),
              renderTexts("Photography",
                  "We offer a team of specialist photographers who are experts in capturing events. They are used to working alongside our camera crews to capture high-quality imagery to preserve your event for posterity.  Events we have cover include: Car Launches Live Music Charity Events Red Carpet Events Investment Conferences Award Ceremonies Launch Parties Film Premieres etc.  We offer a range of day rates to suit different budget requirements but all our photographers are all experienced practitioners who operate with utmost professionalism."),
              renderTexts("Red Carpet Planning", "Red Carpet Planning"),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderTexts(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ),
        Text(
          content,
          style: TextStyle(
            height: 1.2,
            color: Colors.black54,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,

          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            color: Colors.black38,
            height: 8.0,
          ),
        ),
      ],
    );
  }
}
