import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// ignore: always_specify_types
List<String> textStrings = [
  'Salut',
  'Salut\n(Italiana)',
  'Multumesc',
  'Mulutmesc\n(Italiana)',
  'Ma numesc',
  'Ma numesc\n(Italiana)',
  'La revedere',
  'La revedere\n(Italiana)',
];

class _HomePageState extends State<HomePage> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Phrases'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.red,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // ignore: always_specify_types
                    colors: [Colors.blueAccent, Colors.deepPurpleAccent],
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: double.infinity,
                  onPressed: () {
                    assetsAudioPlayer.open(
                      Audio('assets/audio/ciao.mp3'),
                    );
                  },
                  child: Text(
                    '${textStrings[index]}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
