import 'package:flutter/material.dart';

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

String _rating = '6';
String _movieTitle = 'Tuom si Geri';
String _movieGenre = 'Comedie xD';
String _movieYear = '2020';
double _fontSize = 18;
double _sizedBoxSize = 12;

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Browser'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3 - MediaQuery.of(context).size.height / 18,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Image.network('https://img.yts.mx/assets/images/movies/dom_and_adrian_2020_2020/medium-cover.jpg'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$_movieTitle',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: _fontSize + 4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: _sizedBoxSize * 3),
                          Text(
                            'Year: $_movieYear',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: _fontSize,
                            ),
                          ),
                          SizedBox(height: _sizedBoxSize),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: _fontSize + 4,
                              ),
                              Text(
                                ' $_rating/10',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: _fontSize,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: _sizedBoxSize),
                          Text(
                            'Genre: $_movieGenre',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: _fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
