import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future <void> main() async{
  runApp(MyApp());
  final Response response = await get('https://www.worldometers.info/geography/flags-of-the-world/');
  final String data = response.body;

  final List<String> items = data.split('<a href="/img/flags');
  for (final String item in items.skip(1)) {
    flagUrlList.add('https://www.worldometers.info/img/flags${item.split('"')[0]}');

    const String pattern = 'padding-top:10px">';
    countryNameList.add(item.substring(item.indexOf(pattern) + pattern.length, item.indexOf('</div>')));

  }
  print(flagUrlList);
}

List<String> countryNameList;
List<String> flagUrlList;

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

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemCount: 195,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container();
        },
      ),
    );
  }
}

