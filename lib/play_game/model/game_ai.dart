import 'dart:math';

import 'decision.dart';

class GameAI {
  List<List<String>> field;
  String playerChar;
  String aiChar;
  Decision? _decision;

  GameAI({required this.field, required this.playerChar, required this.aiChar});

  Decision? getDecision() {
    _makeDecision();
    return _decision;
  }

  _makeDecision() {
    if (_isCenterEmpty()) return;
    if (_aiIsCloseToWin()) return;
    if (_playerIsCloseToWin()) return;
    if (_playerHasOneChar()) return;
    _chooseRandom();
  }

  bool _isCenterEmpty() {
    if (field[1][1].isEmpty) {
      _decision = Decision(1, 1);
      return true;
    } else {
      return false;
    }
  }

  bool _aiIsCloseToWin() {
    return _hasTwoCharsInLine(0, 0, 0, 1, 0, 2, aiChar) ||
        _hasTwoCharsInLine(1, 0, 1, 1, 1, 2, aiChar) ||
        _hasTwoCharsInLine(2, 0, 2, 1, 2, 2, aiChar) ||
        _hasTwoCharsInLine(0, 0, 1, 0, 2, 0, aiChar) ||
        _hasTwoCharsInLine(0, 1, 1, 1, 2, 1, aiChar) ||
        _hasTwoCharsInLine(0, 2, 1, 2, 2, 2, aiChar) ||
        _hasTwoCharsInLine(0, 0, 1, 1, 2, 2, aiChar) ||
        _hasTwoCharsInLine(0, 2, 1, 1, 2, 0, aiChar);
  }

  bool _playerIsCloseToWin() {
    return _hasTwoCharsInLine(0, 0, 0, 1, 0, 2, playerChar) ||
        _hasTwoCharsInLine(1, 0, 1, 1, 1, 2, playerChar) ||
        _hasTwoCharsInLine(2, 0, 2, 1, 2, 2, playerChar) ||
        _hasTwoCharsInLine(0, 0, 1, 0, 2, 0, playerChar) ||
        _hasTwoCharsInLine(0, 1, 1, 1, 2, 1, playerChar) ||
        _hasTwoCharsInLine(0, 2, 1, 2, 2, 2, playerChar) ||
        _hasTwoCharsInLine(0, 0, 1, 1, 2, 2, playerChar) ||
        _hasTwoCharsInLine(0, 2, 1, 1, 2, 0, playerChar);
  }

  bool _hasTwoCharsInLine(
      int r1, int c1, int r2, int c2, int r3, int c3, String side) {
    if (field[r1][c1] == side &&
        field[r2][c2] == side &&
        field[r3][c3].isEmpty) {
      _decision = Decision(r3, c3);
      return true;
    }
    if (field[r1][c1] == side &&
        field[r3][c3] == side &&
        field[r2][c2].isEmpty) {
      _decision = Decision(r2, c2);
      return true;
    }
    if (field[r2][c2] == side &&
        field[r3][c3] == side &&
        field[r1][c1].isEmpty) {
      _decision = Decision(r1, c1);
      return true;
    }
    return false;
  }

  bool _playerHasOneChar() {
    return _playerHasOneCharInLine(0, 0, 0, 1, 0, 2) ||
        _playerHasOneCharInLine(1, 0, 1, 1, 1, 2) ||
        _playerHasOneCharInLine(2, 0, 2, 1, 2, 2) ||
        _playerHasOneCharInLine(0, 0, 1, 0, 2, 0) ||
        _playerHasOneCharInLine(0, 1, 1, 1, 2, 1) ||
        _playerHasOneCharInLine(0, 2, 1, 2, 2, 2) ||
        _playerHasOneCharInLine(0, 0, 1, 1, 2, 2) ||
        _playerHasOneCharInLine(0, 2, 1, 1, 2, 0);
  }

  _playerHasOneCharInLine(int r1, int c1, int r2, int c2, int r3, int c3) {
    if (field[r1][c1] == playerChar &&
        field[r2][c2].isEmpty &&
        field[r3][c3].isEmpty) {
      _decision = Decision(r3, c3);
      return true;
    }
    if (field[r2][c2] == playerChar &&
        field[r1][c1].isEmpty &&
        field[r3][c3].isEmpty) {
      _decision = Decision(r1, c1);
      return true;
    }
    if (field[r3][c3] == playerChar &&
        field[r1][c1].isEmpty &&
        field[r2][c2].isEmpty) {
      _decision = Decision(r1, c1);
      return true;
    }
    return false;
  }

  _chooseRandom() {
    var random = Random();
    while (true) {
      var row = random.nextInt(3);
      var column = random.nextInt(3);

      if (field[row][column].isEmpty) {
        _decision = Decision(row, column);
        break;
      }
    }
  }
}
