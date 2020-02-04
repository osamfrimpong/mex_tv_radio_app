import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import '../models/models.dart';
import 'package:mextv_app/app_screens/radio_player.dart';

class AllRadiosScreen extends StatefulWidget {
  @override
  _AllRadiosScreenState createState() => _AllRadiosScreenState();
}

class _AllRadiosScreenState extends State<AllRadiosScreen> {
  List<Liveradio> liveRadiosList = new List();
  int itemLength = 0;
  bool isLoading = false;

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
                                builder: (context) => PlayerWidget(liveradio: radioItem,)));
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
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                  )
                  .toList(),
            )
          : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.cloud_off,color: Theme.of(context).primaryColor,size: 54.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No Data!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
              ),
             Text(isLoading?"Loading...":"Please Reload",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54,fontSize: 18.0),),
            ],
          )),
          floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // debugPrint(_tabController.index.toString());
            setState(() {
              isLoading = true;
            });
        Liveradio.fromWeb((liveradioList) {
    Liveradio().saveAll(liveradioList).then((results) {
         Future.delayed(Duration(seconds: 4)).then((onValue){
                setState(() {
                  liveRadiosList = liveradioList;
                  isLoading = false;
                });
              });
    });
  });

        
        },
      ),
    );
  }
}
