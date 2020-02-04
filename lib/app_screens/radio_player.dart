import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';
import 'package:mextv_app/models/models.dart';

enum PlayerState { stopped, playing, paused }

class PlayerWidget extends StatefulWidget {
  // final String url;
  final PlayerMode mode;
  final Liveradio liveradio;

  PlayerWidget({@required this.liveradio, this.mode = PlayerMode.MEDIA_PLAYER});

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState(liveradio, mode);
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  Liveradio liveradio;
  PlayerMode mode;

  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;
  get _isPaused => _playerState == PlayerState.paused;
  get _durationText => _duration?.toString()?.split('.')?.first ?? '00:00';
  get _positionText => _position?.toString()?.split('.')?.first ?? '00:00';

  _PlayerWidgetState(this.liveradio, this.mode);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    debugPrint("radioUrl: ${liveradio.url}");
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

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
                            image: AssetImage(
                                "assets/images/mex_radio_logo_small.png"),
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: 40.0, bottom: 20.0, right: 20.0, left: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _positionText,
                          style: TextStyle(color: Colors.white54),
                        ),
                        IconButton(
                            icon: Icon(Icons.skip_previous),
                            color: Colors.white70,
                            onPressed: () {}),
                        _isPlaying
                            ? CircleAvatar(
                                backgroundColor: Colors.red,
                                child: IconButton(
                                    icon: Icon(Icons.pause),
                                    color: Colors.white,
                                    onPressed: () {
                                       _pause();
                                    }),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.red,
                                child: IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    color: Colors.white,
                                    onPressed: () {
                                      _play();
                                    }),
                              ),
                        IconButton(
                            icon: Icon(Icons.skip_next),
                            color: Colors.white70,
                            onPressed: () {}),
                        Text(
                          _positionText,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);

   
      // if (Theme.of(context).platform == TargetPlatform.iOS) {
      //   // (Optional) listen for notification updates in the background
      //   _audioPlayer.startHeadlessService();

      //   // set at least title to see the notification bar on ios.
      //   _audioPlayer.setNotification(
      //       title: 'App Name',
      //       artist: 'Artist or blank',
      //       albumTitle: 'Name or blank',
      //       imageUrl: 'url or blank',
      //       forwardSkipInterval: const Duration(seconds: 30), // default is 30s
      //       backwardSkipInterval: const Duration(seconds: 30), // default is 30s
      //       duration: duration,
      //       elapsedTime: Duration(seconds: 0));
      // }
    });

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;
      });
    });

    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _audioPlayerState = state);
    });
  }

  Future<int> _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result =
        await _audioPlayer.play(liveradio.url, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);

    // default playback rate is 1.0
    // this should be called after _audioPlayer.play() or _audioPlayer.resume()
    // this can also be called everytime the user wants to change playback rate in the UI
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);

    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }
}
