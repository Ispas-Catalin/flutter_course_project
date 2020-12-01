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

int numberValue;
String errorText;
bool ok = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Shapes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            // ignore: prefer_const_literals_to_create_immutables
            const Text(
              'Please input a number to see if it is square or triangle.',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            setState(() {
              if (ok == false) {
                errorText = 'Please input a number';
              } else {
                errorText = null;
              }
            });
            if (ok) {
              showDialog<Widget>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(numberValue.toString()),
                      content: Text(generateResText(numberValue)),
                    );
                  });
            }
          }),
    );
  }
}

String generateResText(int number) {
  bool isSquare, isCube;

  if (pow(number, 1 / 2).toInt() == pow(number, 1 / 2))
    isSquare = true;
  else
    isSquare = false;

  if (pow(number, 1 / 3).toInt() == pow(number, 1 / 3))
    isCube = true;
  else
    isCube = false;

  if (isSquare && isCube) return '$number is both a SQUARE and TRIANGULAR.';
  if (!isSquare && !isCube)
    return '$number is neither a SQUARE nor a TRIANGULAR.';
  if (isSquare && !isCube) return '$number is a SQUARE.';
  if (!isSquare && isCube)
    return '$number is a TRIANGULAR.';
  else
    return '';
}
