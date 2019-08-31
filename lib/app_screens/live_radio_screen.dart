import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import 'package:audioplayer/audioplayer.dart';
import 'dart:async';
import 'package:mextv_app/models/models.dart';

typedef void OnError(Exception exception);

//const kUrl = "https://s3.radio.co/s66936a46e/listen";


enum PlayerState { stopped, playing, paused }

//full scaffold
class LiveRadio extends StatefulWidget {
  final Liveradio liveradio;

  LiveRadio({Key key, @required this.liveradio}) : super(key: key);

  @override
  _LiveRadioState createState() => _LiveRadioState();
}

class _LiveRadioState extends State<LiveRadio> {
 // bool _isPlaying = false;

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '00:00';
  get positionText =>
      position != null ? position.toString().split('.').first : '00:00';


  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    // _positionSubscription.cancel();
    // _audioPlayerStateSubscription.cancel();
    // audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
          if (s == AudioPlayerState.PLAYING) {
            setState(() => duration = audioPlayer.duration);
          } else if (s == AudioPlayerState.STOPPED) {
            onComplete();
            setState(() {
              position = duration;
            });
          }
        }, onError: (msg) {
          setState(() {
            playerState = PlayerState.stopped;
            duration = new Duration(seconds: 0);
            position = new Duration(seconds: 0);
          });
        });
  }

  Future play() async {
    await audioPlayer.play(widget.liveradio.url);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

//  Future _playLocal() async {
//    await audioPlayer.play(localFilePath, isLocal: true);
//    setState(() => playerState = PlayerState.playing);
//  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

//  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
//    Uint8List bytes;
//    try {
//      bytes = await readBytes(url);
//    } on ClientException {
//      rethrow;
//    }
//    return bytes;
//  }

//  Future _loadFile() async {
//    final bytes = await _loadFileBytes(kUrl,
//        onError: (Exception exception) =>
//            print('_loadFile => exception $exception'));
//
//    final dir = await getApplicationDocumentsDirectory();
//    final file = new File('${dir.path}/audio.mp3');
//
//    await file.writeAsBytes(bytes);
//    if (await file.exists())
//      setState(() {
//        localFilePath = file.path;
//      });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("Live Radio"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/photo_singer_female.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Opacity(
            opacity: 0.9,
            child: Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                    Colors.black,
                    Colors.grey,
                    Colors.black,
                  ],
                      stops: [
                    0.05,
                    0.4,
                    0.5
                  ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      tileMode: TileMode.repeated)),
            ),
          ),
          ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                    child: Text(
                      "NOW PLAYING",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/mex_radio_logo_small.png"),
                            fit: BoxFit.contain,
                          ),
//                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          border:
                              Border.all(color: Colors.black12, width: 4.0)),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
                    child: Text(
                      widget.liveradio.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 40.0,bottom: 20.0,right: 20.0,left: 20.0),child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(positionText,style: TextStyle(color: Colors.white54),),
                      IconButton(icon: Icon(Icons.skip_previous),color: Colors.white70, onPressed: (){}),
                      isPlaying ? CircleAvatar(backgroundColor: Colors.red,child: IconButton(icon: Icon(Icons.pause), color: Colors.white, onPressed: () {
                        pause();
                      }),) :
                      CircleAvatar(backgroundColor: Colors.red,child: IconButton(icon: Icon(Icons.play_arrow), color: Colors.white, onPressed: () {
                        play();
                      }),),
                      IconButton(icon: Icon(Icons.skip_next),color: Colors.white70, onPressed: (){}),
                      Text(positionText,style: TextStyle(color: Colors.white54),),
                    ],
                  ),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
