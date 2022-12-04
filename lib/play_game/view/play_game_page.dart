import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tic_tac_toe/app.dart';
import 'package:tic_tac_toe/play_game/model/game_ai.dart';
import 'package:tic_tac_toe/play_game/model/victory.dart';
import 'package:tic_tac_toe/play_game/model/victory_checker.dart';
import 'package:tic_tac_toe/play_game/widgets/victory_line.dart';
import 'package:tic_tac_toe/shared/widgets/widgets.dart';

class PlayGamePage extends HookWidget {
  final String playerChar;
  final String aiChar;

  const PlayGamePage({
    Key? key,
    required this.playerChar,
    required this.aiChar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final victory =
        useState<Victory>(Victory(0, 0, LineType.none, Winner.none));
    final playersTurn = useState(true);
    final aisTurn = useState(false);
    final fields = useState<List<List<String>>>([
      ['', '', ''],
      ['', '', ''],
      ['', '', '']
    ]);
    final gameAi = useState(
      GameAI(field: fields.value, playerChar: playerChar, aiChar: aiChar),
    );
    final confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );

    void checkForVictory() {
      var checkedVictory =
          VictoryChecker.checkForVictory(fields.value, playerChar);

      if (checkedVictory != null) {
        aisTurn.value = false;
        playersTurn.value = false;
        victory.value = checkedVictory;
        String? message;

        if (victory.value.winner == Winner.player) {
          message = 'You Win!';
        } else if (victory.value.winner == Winner.ai) {
          message = 'AI Wins!';
        } else if (victory.value.winner == Winner.draw) {
          message = 'It\'s a tie!';
        }

        if (message != null) {
          confettiController.play();
          showDialog(
            context: context,
            builder: (context) {
              return Material(
                type: MaterialType.transparency,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: victory.value.winner == Winner.player,
                      child: Stack(
                        children: [
                          const LikeWidget(
                            height: 150,
                            width: 150,
                          ),
                          ConfettiWidget(
                            confettiController: confettiController,
                            blastDirectionality: BlastDirectionality.explosive,
                            shouldLoop: true,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: victory.value.winner == Winner.player,
                      child: const SizedBox(height: 20),
                    ),
                    Text(
                      message!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }
    }

    bool allCellsAreTaken() {
      var field = fields.value;
      return field[0][0].isNotEmpty &&
          field[0][1].isNotEmpty &&
          field[0][2].isNotEmpty &&
          field[1][0].isNotEmpty &&
          field[1][1].isNotEmpty &&
          field[1][2].isNotEmpty &&
          field[2][0].isNotEmpty &&
          field[2][1].isNotEmpty &&
          field[2][2].isNotEmpty;
    }

    bool gameIsDone() {
      return allCellsAreTaken() || victory.value.winner != Winner.none;
    }

    registerAiTurn(int row, int column) {
      aisTurn.value = true;
      Timer(const Duration(milliseconds: 500), () {
        var aiDecision = gameAi.value.getDecision();
        fields.value[aiDecision!.row][aiDecision.column] = aiChar;
        // fields.notifyListeners();
        Timer(const Duration(milliseconds: 500), () {
          // Timer(const Duration(milliseconds: 600), () {
          //   checkForVictory();
          // });
          checkForVictory();
          if (victory.value.winner == Winner.none) {
            aisTurn.value = false;
            playersTurn.value = true;
          }
        });
      });
    }

    registerPlayerTurn(int row, int column) {
      playersTurn.value = false;
      List<List<String>> newFields = fields.value;
      newFields[row][column] = playerChar;
      fields.value = newFields;
      // fields.notifyListeners();
      Timer(const Duration(milliseconds: 600), () {
        checkForVictory();
        Timer(const Duration(milliseconds: 1000), () {
          playersTurn.value = false;
          if (!gameIsDone()) registerAiTurn(row, column);
        });
      });
    }

    playAgain() {
      victory.value = Victory(0, 0, LineType.none, Winner.none);
      playersTurn.value = true;
      aisTurn.value = false;
      fields.value = [
        ['', '', ''],
        ['', '', ''],
        ['', '', '']
      ];
      gameAi.value =
          GameAI(field: fields.value, playerChar: playerChar, aiChar: aiChar);
    }

    const titleTheme = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    const infoTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Tic-Tac-Toe'.toUpperCase(),
          style: titleTheme,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width > 420
              ? 400
              : MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 60),
                  Stack(
                    children: [
                      const _GameGrid(),
                      _GameFields(
                        fields: fields.value,
                        registerPlayerTurn: registerPlayerTurn,
                        registerAiTurn: registerAiTurn,
                        gameIsDone: () => gameIsDone(),
                        playersTurn: playersTurn.value,
                      ),
                      buildVictoryLine(victory.value),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    child: () {
                      if (playersTurn.value) {
                        return Column(
                          children: const [
                            _BottomLoader(),
                            SizedBox(height: 15),
                            Text('Your Turn', style: infoTextStyle),
                          ],
                        );
                      } else if (aisTurn.value) {
                        return Column(
                          children: const [
                            _BottomLoader(),
                            SizedBox(height: 15),
                            Text('Thinking', style: infoTextStyle),
                          ],
                        );
                      } else if (gameIsDone()) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => playAgain(),
                              child:
                                  const Text('Play Again', style: titleTheme),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () => Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              ),
                              child: const Text('Main Menu', style: titleTheme),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }(),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVictoryLine(Victory victory) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: VictoryLine(victory: victory),
    );
  }
}

class _GameFields extends HookWidget {
  final List<List<String>> fields;
  final Function(int row, int column) registerPlayerTurn;
  final Function(int row, int column) registerAiTurn;
  final Function gameIsDone;
  final bool playersTurn;

  const _GameFields({
    Key? key,
    required this.fields,
    required this.registerPlayerTurn,
    required this.registerAiTurn,
    required this.gameIsDone,
    required this.playersTurn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCell(0, 0),
                buildCell(0, 1),
                buildCell(0, 2),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCell(1, 0),
                buildCell(1, 1),
                buildCell(1, 2),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCell(2, 0),
                buildCell(2, 1),
                buildCell(2, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCell(int row, int column) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: GestureDetector(
        onTap: () {
          if (!gameIsDone() && playersTurn) {
            registerPlayerTurn(row, column);
            // if (!gameIsDone()) {
            //   registerAiTurn(row, column);
            // }
          }
        },
        child: buildCellItem(row, column),
      ),
    );
  }

  Widget buildCellItem(int row, int column) {
    var cell = fields[row][column];
    if (cell.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cell == 'x'
              ? const XWidget(
                  height: 70,
                  width: 70,
                  strokeWidth: 25,
                )
              : const OWidget(
                  height: 70,
                  width: 70,
                  radius: 40,
                  strokeWidth: 25,
                ),
        ],
      );
    } else {
      return Container(
        height: 20,
        width: 20,
        color: Colors.transparent,
      );
    }
  }
}

class _GameGrid extends StatelessWidget {
  const _GameGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 0.9,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _HorizontalLine(),
                  _HorizontalLine(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _VerticalLine(),
                  _VerticalLine(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VerticalLine extends StatelessWidget {
  const _VerticalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 7.0,
    );
  }
}

class _HorizontalLine extends StatelessWidget {
  const _HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 7.0,
    );
  }
}

class _BottomLoader extends HookWidget {
  const _BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = useState<double>(25);

    useEffect(() {
      Timer(const Duration(milliseconds: 250), () {
        padding.value = 10;
      });
      return () {};
    }, []);
    List<Widget> xo = [
      const XWidget(
        height: 30,
        width: 30,
        strokeWidth: 10,
      ),
      const OWidget(
        height: 30,
        width: 30,
        strokeWidth: 10,
        radius: 15,
      )
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.only(right: padding.value),
          child: xo[Random().nextInt(2)],
        ),
        xo[Random().nextInt(2)],
      ],
    );
  }
}
