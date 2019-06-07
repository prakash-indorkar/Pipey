import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';
import 'package:flutter_android_pip/flutter_android_pip.dart';

import 'package:pip_pipey/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pipey",
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/settings': (context) => Settings(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _videoUrl = "h-4XCZ-qQs0";
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_textEditingController.text);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pipey"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: _textEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Enter YouTube Video URL",
                  ),
                ),
              ),
              _textEditingController.text.isNotEmpty
                  ? VideoContainer(_videoUrl)
                  : Container(),
              Container(
                  margin: EdgeInsets.all(16),
                  child: RaisedButton(
                    child: Text("Play"),
                    onPressed: () {
                      if (_textEditingController.text.isNotEmpty) {
                        setState(() {
                          List<String> urlParts;
                          if (_textEditingController.text
                              .contains("youtu.be")) {
                            urlParts = _textEditingController.text.split("/");
                          } else {
                            urlParts = _textEditingController.text.split("=");
                          }
                          _videoUrl = urlParts[urlParts.length - 1];
                        });
                        FlutterAndroidPip.enterPictureInPictureMode;
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoContainer extends StatelessWidget {
  final String _videoUrl;

  VideoContainer(this._videoUrl);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: YoutubePlayer(
              autoPlay: true,
              context: context,
              source: _videoUrl,
              quality: YoutubeQuality.LOW,
            ),
          ),
        ],
      ),
    );
  }
}
