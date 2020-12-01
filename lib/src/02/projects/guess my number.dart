import 'dart:math';

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

Random random = Random();

String hintText = 'You tryed 52';
String errorText;
bool _isVisible = false;
bool ok;
int numberValue;
int myNumber = random.nextInt(100);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Center(
              child: Text(
                'I\'m thinking of a number between\n1 and 100',
                style: TextStyle(color: Colors.black, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'It\'s your turn to guess my number.',
                style: TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: Text(
                hintText,
                style: const TextStyle(color: Colors.grey, fontSize: 40),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 16,
              child: Card(
                margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Text(
                        'Try a number!',
                        style: TextStyle(color: Colors.grey, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                        decoration: InputDecoration(
                          errorText: errorText,
                        ),
                        onChanged: (String value) {
                          if (int.tryParse(value) == null)
                            ok = false;
                          else {
                            ok = true;
                            numberValue = int.parse(value);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              if (!ok) {
                                errorText = 'Please imput a number';
                                _isVisible = false;
                              }
                              if (ok) {
                                errorText = null;
                                _isVisible = true;
                                if (myNumber > numberValue) hintText = 'You tried $numberValue\nTry Higher';
                                if (myNumber < numberValue) hintText = 'You tried $numberValue\nTry Lower';
                                if (myNumber == numberValue) {
                                  hintText = 'you are correct';
                                }
                              }
                            });
                          },
                          child: const Text('Guess'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
