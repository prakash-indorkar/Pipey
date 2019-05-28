import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';
import 'package:flutter_android_pip/flutter_android_pip.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pipey",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _action = "Play";
  String _videoUrl = "h-4XCZ-qQs0";
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pipey"),
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
              Container(
                child: YoutubePlayer(
                  autoPlay: true,
                  context: context,
                  source: _videoUrl,
                  quality: YoutubeQuality.LOW,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(16),
                  child: RaisedButton(
                    child: Text(_action),
                    onPressed: () {
                      setState(() {
                        if (_textEditingController.text.isNotEmpty) {
                          List<String> urlParts =
                              _textEditingController.text.split("/");
                          _videoUrl = urlParts[urlParts.length - 1];
                        }
                      });
                      FlutterAndroidPip.enterPictureInPictureMode;
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
