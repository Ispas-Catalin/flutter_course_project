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

double res = 50.00;
double _visible = 0.0;
String hintText = 'enter the amount in EUR';
String errorText;
String resValue;

ScrollController _scrollController = ScrollController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency convertor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Image.asset(
                'assets/images/lei.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 6 / 8,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                onChanged: (String value) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 200),
                  );
                  resValue = value;
                },
                decoration: InputDecoration(
                  hintText: '$hintText',
                  errorText: errorText,
                ),
              ),
            ),
            RaisedButton(
                child: Text('Convert!'),
                onPressed: () {
                  setState(() {
                    if (resValue == null) {
                      errorText = 'please enter a number';
                      _visible = 0.0;
                    } else if (double.tryParse(resValue) != null) {
                      errorText = null;
                      _visible = 1.0;
                      res = double.parse(resValue) * 4.5;
                    } else {
                      errorText = 'please enter a number';
                      _visible = 0.0;
                    }
                  });
                }),
            Opacity(
              opacity: _visible,
              child: Text(
                res.toStringAsFixed(2) + ' RON',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
