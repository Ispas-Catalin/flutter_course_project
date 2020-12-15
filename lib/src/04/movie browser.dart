import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

double _fontSize = 18;
double _sizedBoxSize = 12;

// ignore: always_specify_types
List<String> _movieTitle = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
// ignore: always_specify_types
List<String> _movieImage = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
// ignore: always_specify_types
List<String> _backroundImage = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
// ignore: always_specify_types
List<String> _movieYear = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
// ignore: always_specify_types
List<String> _movieRating = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
// ignore: always_specify_types
List<String> _movieGenre = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
// ignore: always_specify_types
List<String> _auxList = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];

String _page = '1';
String _minimumRating = '0';
int _minimumRatingInt = 0;
int _builderItemCount = 20;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final Response response = await get('https://yts.mx/api/v2/list_movies.json?minimum_rating=$_minimumRating');
    final Map<String, dynamic> map = jsonDecode(response.body);
    for (int i = 0; i <= 19; i++) {
      setState(() {
        _backroundImage[i] = map['data']['movies'][i]['background_image'];
        _movieTitle[i] = map['data']['movies'][i]['title'];
        _movieImage[i] = map['data']['movies'][i]['medium_cover_image'];
        _movieYear[i] = map['data']['movies'][i]['year'].toString();
        _movieRating[i] = map['data']['movies'][i]['rating'].toString();
        _movieGenre[i] = map['data']['movies'][i]['genres'][0];
      });
    }
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
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    // ignore: always_specify_types
                    builder: (BuildContext context, setState) {
                      return AlertDialog(
                        title: Text(
                          'Minimum rating',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _fontSize + 4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: <Widget>[
                          Slider(
                            value: _minimumRatingInt.toDouble(),
                            min: 0.0,
                            max: 10.0,
                            onChanged: (double value) {
                              setState(() {
                                _minimumRatingInt = value.toInt();
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'At least $_minimumRatingInt/10',
                                style: TextStyle(
                                  fontSize: _fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: _fontSize + 4,
                              ),
                            ],
                          ),
                          MaterialButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              clearData();
                              getData();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: _builderItemCount + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _builderItemCount) {
            return MaterialButton(
              child: const Text('Show more'),
              onPressed: () {
                setState(() {
                  _backroundImage.addAll(_auxList);
                  _movieTitle.addAll(_auxList);
                  _movieImage.addAll(_auxList);
                  _movieYear.addAll(_auxList);
                  _movieRating.addAll(_auxList);
                  _movieGenre.addAll(_auxList);
                  _builderItemCount = _builderItemCount + 20;
                  addData();
                });
                Timer(const Duration(seconds: 1), _refresh);
              },
            );
          } else
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Image.network('${_backroundImage[index]}'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ' ${_movieTitle[index]} ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _fontSize + 4,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Image.network('${_movieImage[index]}'),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: _sizedBoxSize * 3),
                                      Text(
                                        ' Year: ${_movieYear[index]} ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: _fontSize,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(height: _sizedBoxSize),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            color: Colors.black.withOpacity(0.5),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: _fontSize + 4,
                                            ),
                                          ),
                                          Text(
                                            '  ${_movieRating[index]}/10 ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: _fontSize,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor: Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: _sizedBoxSize),
                                      Text(
                                        ' Genre: ${_movieGenre[index]} ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: _fontSize,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }

  Future<void> addData() async {
    _page = (int.tryParse(_page) + 1).toString();
    final Response response =
        await get('https://yts.mx/api/v2/list_movies.json?page=$_page&minimum_rating=$_minimumRating&limit=20');
    final Map<String, dynamic> map = jsonDecode(response.body);
    for (int i = 0; i <= 19; i++) {
      _backroundImage[i + _builderItemCount - 20] = map['data']['movies'][i]['background_image'];
      _movieTitle[i + _builderItemCount - 20] = map['data']['movies'][i]['title'];
      _movieImage[i + _builderItemCount - 20] = map['data']['movies'][i]['medium_cover_image'];
      _movieYear[i + _builderItemCount - 20] = map['data']['movies'][i]['year'].toString();
      _movieRating[i + _builderItemCount - 20] = map['data']['movies'][i]['rating'].toString();
      _movieGenre[i + _builderItemCount - 20] = '420';
    }
  }

  void _refresh() {
    setState(() {
      // ignore: unnecessary_statements
      _backroundImage;
      // ignore: unnecessary_statements
      _movieTitle;
      // ignore: unnecessary_statements
      _movieImage;
      // ignore: unnecessary_statements
      _movieYear;
      // ignore: unnecessary_statements
      _movieRating;
      // ignore: unnecessary_statements
      _movieGenre;
    });
  }

  void clearData() {
    _minimumRating = _minimumRatingInt.toString();
    _builderItemCount = 20;
    _page = '1';
  }
}
