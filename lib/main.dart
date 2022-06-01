import 'package:flutter/material.dart';
import 'package:flutter_music_app/music.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int choosedmusic = 1;
  bool displayed = true;
  final _player = AudioPlayer();
  String songDuration = "";

  List<Music> myMusicList = [
    Music('Sur les toits', 'Youv Dee', 'assets/laviedeluxe.jpg',
        'assets/music/youv-dee-sur-les-toits.mp3'),
    Music('BUTTERFLY EFFECT', 'Travis Scott', 'assets/astroworld.jpg',
        'assets/music/travis-scott-butterfly-effect.mp3'),
    Music('Fumée', 'Sheldon', 'assets/Spectre.jpg',
        'assets/music/sheldon-fumee.mp3'),
    Music('Thought it was a drought', 'Future', 'assets/DS2.jpg',
        'assets/music/thought-it-was-a-drought.mp3'),
    Music('Suga Suga', 'Népal, Doums', 'assets/2016-2018.jpg',
        'assets/music/suga-suga.mp3'),
    Music(
        'Violette et Citronelle',
        'Alkpote, Zzccmxtp',
        'assets/violette_et_citronelle.jpg',
        'assets/music/violette_et_citronelle.mp3'),
  ];

  Future<void> _play(int choosedmusic) async {
    await _player.setAsset(myMusicList[choosedmusic].urlSong).then((value) => {
          setState(() {
            songDuration = "${value!.inMinutes}:${value.inSeconds % 60}";
          })
        });
  }

  @override
  void initState() {
    super.initState();
    _play(choosedmusic);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('YNOVIFY'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.grey[850],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                  elevation: 0.9,
                  child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Image.asset(myMusicList[choosedmusic].imagePath))),
              Text(myMusicList[choosedmusic].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              Text(myMusicList[choosedmusic].singer,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.fast_rewind),
                    onPressed: () => setState(() {
                      if (choosedmusic == 0) {
                        choosedmusic = myMusicList.length - 1;
                        _play(choosedmusic);
                      } else {
                        choosedmusic--;
                        _play(choosedmusic);
                      }
                    }),
                    color: Colors.white,
                    iconSize: 50,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(
                      color: Colors.white,
                      iconSize: 60,
                      icon: Icon(displayed ? Icons.play_arrow : Icons.pause),
                      onPressed: () {
                        setState(() {
                          displayed = !displayed;
                          (displayed ? _player.pause() : _player.play());
                        });
                      }),
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    icon: Icon(Icons.fast_forward),
                    onPressed: () => setState(() {
                      if (choosedmusic == myMusicList.length - 1) {
                        choosedmusic = 0;
                        _play(choosedmusic);
                      } else {
                        choosedmusic++;
                        _play(choosedmusic);
                      }
                    }),
                    color: Colors.white,
                    iconSize: 50,
                  )
                ],
              ),
              Text("Durée : $songDuration",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )),
            ],
          ),
        ),
      );
}
