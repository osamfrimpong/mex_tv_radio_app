import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import '../models/models.dart';
import 'package:mextv_app/app_screens/live_radio_screen.dart';

class AllRadiosScreen extends StatefulWidget {
  @override
  _AllRadiosScreenState createState() => _AllRadiosScreenState();
}

class _AllRadiosScreenState extends State<AllRadiosScreen> {
  List<Liveradio> liveRadiosList = new List();
  int itemLength = 0;

  @override
  void initState() {
    super.initState();
    Liveradio().select().toList((liveradiolist) {
      this.setState(() {
        this.liveRadiosList = liveradiolist;
        this.itemLength = liveradiolist.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("Radio List: "+itemLength.toString());

    return Scaffold(
      appBar: MexAppBar.create("Live Radios"),
      body: liveRadiosList.length > 0
          ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              padding: EdgeInsets.all(10.0),
              children: liveRadiosList
                  .map(
                    (radioItem) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LiveRadio(liveradio: radioItem,)));
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/radiobanner.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: 0.8,
                                child: Container(
                                  color: Colors.black,
                                ),
                              ),
                              Center(
                                child: Text(
                                  radioItem.title,
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
                  )
                  .toList(),
            )
          : Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "No Live Radios. Ensure You Have An Active Internet Connection and Restart the App",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
                  ),
                ),
              ),
            ),
    );
  }
}
