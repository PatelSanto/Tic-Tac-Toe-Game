import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialouge.dart';
import 'package:tic_tac_toe/game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonlist;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonlist = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

// after on pressed
  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = 'X';
        gb.bg = Colors.blue;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = 'O';
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonlist.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => CustomDialogue("Game Tied",
                  "Please! Press Reset Button to Start Again", resetGame));
        }
      }
    });
  }

  int checkWinner() {
    var winner = -1;
    // row1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 1;
    }
    // row2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 1;
    }
    // row3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 1;
    }
    // column1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 1;
    }
    // column2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 1;
    }
    // column3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 1;
    }
    // diagonal1
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 1;
    }
    // diagonal2
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 1;
    }
    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialogue(
                  "Player 1 Won",
                  "Please! Press Reset Button to Start Again",
                  resetGame,
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialogue(
                  "Player 2 Won",
                  "Please! Press Reset Button to Start Again",
                  resetGame,
                ));
      }
    }
    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonlist = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tic Tac Toe'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff6921e), Color(0xffee4036)])),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 160, left: 20, right: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 9.0),
                  itemCount: buttonlist.length,
                  itemBuilder: (context, index) => SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: buttonlist[index].enabled
                            ? () => playGame(buttonlist[index])
                            : null,
                        child: Text(buttonlist[index].text,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonlist[index].bg,
                            disabledBackgroundColor: buttonlist[index].bg),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                onPressed: resetGame,
              ),
            )
          ],
        ),
      ),
    );
  }
}
