import 'package:tic_tac_toe/play_game/model/victory.dart';

class VictoryChecker {
  static Victory? checkForVictory(List<List<String>> field, String playerChar) {
    Victory? v;
    //check horizontal lines
    if (field[0][0].isNotEmpty &&
        field[0][0] == field[0][1] &&
        field[0][0] == field[0][2]) {
      v = Victory(0, 0, LineType.horizontal,
          field[0][0] == playerChar ? Winner.player : Winner.ai);
    } else if (field[1][0].isNotEmpty &&
        field[1][0] == field[1][1] &&
        field[1][0] == field[1][2]) {
      v = Victory(1, 0, LineType.horizontal,
          field[1][0] == playerChar ? Winner.player : Winner.ai);
    } else if (field[2][0].isNotEmpty &&
        field[2][0] == field[2][1] &&
        field[2][0] == field[2][2]) {
      v = Victory(2, 0, LineType.horizontal,
          field[2][0] == playerChar ? Winner.player : Winner.ai);
    }

    //check vertical lines
    else if (field[0][0].isNotEmpty &&
        field[0][0] == field[1][0] &&
        field[0][0] == field[2][0]) {
      v = Victory(0, 0, LineType.vertical,
          field[0][0] == playerChar ? Winner.player : Winner.ai);
    } else if (field[0][1].isNotEmpty &&
        field[0][1] == field[1][1] &&
        field[0][1] == field[2][1]) {
      v = Victory(0, 1, LineType.vertical,
          field[0][1] == playerChar ? Winner.player : Winner.ai);
    } else if (field[0][2].isNotEmpty &&
        field[0][2] == field[1][2] &&
        field[0][2] == field[2][2]) {
      v = Victory(0, 2, LineType.vertical,
          field[0][2] == playerChar ? Winner.player : Winner.ai);
    }

    //check diagonal
    else if (field[0][0].isNotEmpty &&
        field[0][0] == field[1][1] &&
        field[0][0] == field[2][2]) {
      v = Victory(0, 0, LineType.diagonal_descending,
          field[0][0] == playerChar ? Winner.player : Winner.ai);
    } else if (field[2][0].isNotEmpty &&
        field[2][0] == field[1][1] &&
        field[2][0] == field[0][2]) {
      v = Victory(2, 0, LineType.diagonal_ascending,
          field[2][0] == playerChar ? Winner.player : Winner.ai);
    } else if (field[0][0].isNotEmpty &&
        field[0][1].isNotEmpty &&
        field[0][2].isNotEmpty &&
        field[1][0].isNotEmpty &&
        field[1][1].isNotEmpty &&
        field[1][2].isNotEmpty &&
        field[2][0].isNotEmpty &&
        field[2][1].isNotEmpty &&
        field[2][2].isNotEmpty) {
      v = Victory(-1, -1, LineType.none, Winner.draw);
    }

    return v;
  }
}
