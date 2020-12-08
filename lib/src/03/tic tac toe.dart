import 'package:flutter/cupertino.dart';
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

String scoreO = '0';
String scoreX = '0';
String empty = 'assets/images/transparent.jpg';
String announcementText = 'X won';
int counter = 0;
bool gameOk = true;
bool winner, winnerOk;
bool isVisibleButton = false;

// ignore: always_specify_types
List<String> gameImage = [
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
  'assets/images/transparent.jpg',
];

// ignore: always_specify_types
List<int> gameStage = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
];

// ignore: always_specify_types
List<Color> colors = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
];
Color winColor = Colors.green;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  const Text(
                    'Score',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Positioned(
                    left: 0,
                    child: Card(
                      color: Colors.red[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              'O : ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '$scoreO',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Card(
                      color: Colors.green[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '$scoreX',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              ' : X',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 16,
              child: Card(
                color: Colors.indigo,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return AnimatedContainer(
                        color: colors[index],
                        duration: const Duration(milliseconds: 1000),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white.withOpacity(0.8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                          ),
                          onPressed: () {
                            setState(() {
                              if (gameOk == true) {
                                playGame(index);
                              }
                            });
                          },
                          child: Image.asset(
                            '${gameImage[index]}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Visibility(
              visible: isVisibleButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        resetGame();
                      });
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        playAgain();
                      });
                    },
                    child: const Text(
                      'Play again',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisibleButton,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$announcementText',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 38
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void playGame(int index) {
  if (gameImage[index] == 'assets/images/transparent.jpg') {
    counter++;
    gameImage[index] = getImage(counter % 2);
    gameStage[index] = counter % 2 + 10;
  }
  checkGame();
}

String getImage(int state) {
  if (state == 1) {
    return 'assets/images/X.jpg';
  }
  if (state == 0) {
    return 'assets/images/O.jpg';
  }
  return 'assets/images/transparent.jpg';
}

void checkGame() {
  // ignore: prefer_final_locals, always_specify_types
  List<int> check = [
    gameStage[0] + gameStage[4] + gameStage[8],
    gameStage[0] + gameStage[3] + gameStage[6],
    gameStage[1] + gameStage[4] + gameStage[7],
    gameStage[2] + gameStage[5] + gameStage[8],
    gameStage[2] + gameStage[4] + gameStage[6],
    gameStage[2] + gameStage[1] + gameStage[0],
    gameStage[5] + gameStage[4] + gameStage[3],
    gameStage[8] + gameStage[7] + gameStage[6],
  ];
  if(counter == 9){
    gameOk=false;
    announceWinner(-1);
    winnerOk=false;
  }
  for (int i = 0; i <= 7; i++) {
    if (check[i] == 30) {
      gameOk = false;
      winner = true;
      winnerOk = true;
      announceWinner(i);
    }
    if (check[i] == 33) {
      gameOk = false;
      winner = false;
      winnerOk = true;
      announceWinner(i);
    }
  }
}

void announceWinner(int animationType) {

  if(animationType == -1)
  {
    announcementText = 'Tie!';
  }

  if (winnerOk == true) {
    winnerOk = false;
    if (!winner) {
      scoreX = (int.tryParse(scoreX) + 1).toString();
      winColor = Colors.green;
      announcementText = 'X won!';
    } else {
      scoreO = (int.tryParse(scoreO) + 1).toString();
      winColor = Colors.red;
      announcementText = 'O won!';
    }
  }

  isVisibleButton = true;

  if (animationType == 0) {
    colors[0] = winColor;
    colors[4] = winColor;
    colors[8] = winColor;
  }
  if (animationType == 1) {
    colors[0] = winColor;
    colors[3] = winColor;
    colors[6] = winColor;
  }
  if (animationType == 2) {
    colors[1] = winColor;
    colors[4] = winColor;
    colors[7] = winColor;
  }
  if (animationType == 3) {
    colors[2] = winColor;
    colors[5] = winColor;
    colors[8] = winColor;
  }
  if (animationType == 4) {
    colors[2] = winColor;
    colors[4] = winColor;
    colors[6] = winColor;
  }
  if (animationType == 5) {
    colors[2] = winColor;
    colors[1] = winColor;
    colors[0] = winColor;
  }
  if (animationType == 6) {
    colors[5] = winColor;
    colors[4] = winColor;
    colors[3] = winColor;
  }
  if (animationType == 7) {
    colors[8] = winColor;
    colors[7] = winColor;
    colors[6] = winColor;
  }
}

void resetGame() {
  isVisibleButton = false;
  // ignore: always_specify_types
  gameImage = [
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
  ];
  counter = 0;
  // ignore: always_specify_types
  gameStage = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  scoreO = '0';
  scoreX = '0';
  gameOk = true;
  // ignore: always_specify_types
  colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
}

void playAgain() {
  isVisibleButton = false;
  // ignore: always_specify_types
  gameImage = [
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
  ];
  counter = 0;
  // ignore: always_specify_types
  gameStage = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  gameOk = true;
  // ignore: always_specify_types
  colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
}
