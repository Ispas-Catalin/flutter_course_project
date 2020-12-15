import 'dart:convert';

import 'package:http/http.dart';

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

Future<void> main() async {
  final Response response = await get('https://yts.mx/api/v2/list_movies.json');
  final Map<String, dynamic> map = jsonDecode(response.body);
  for (int i = 0; i <= 19; i++) {
    _backroundImage[i] = map['data']['movies'][i]['background_image'];
    _movieTitle[i] = map['data']['movies'][i]['title'];
    _movieImage[i] = map['data']['movies'][i]['medium_cover_image'];
    _movieYear[i] = map['data']['movies'][i]['year'].toString();
    _movieRating[i] = map['data']['movies'][i]['rating'].toString();
    _movieGenre[i] = map['data']['movies'][i]['genres'][0];
  }

  print(map['data']['movies'][0]['title']);
  print(map['data']['movies'][0]['year'].toString());

  print(map['data']['movies'][1]['title']);
  print(map['data']['movies'][1]['year'].toString());

  print(map['data']['movies'][2]['title']);
  print(map['data']['movies'][2]['year'].toString());

  print(map['data']['movies'][2]['title']);
  print(map['data']['movies'][3]['year'].toString());
}
