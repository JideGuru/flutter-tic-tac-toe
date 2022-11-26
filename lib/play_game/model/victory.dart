class Victory {
  int row;
  int col;
  LineType lineType;
  Winner winner;

  Victory(this.row, this.col, this.lineType, this.winner);
}

enum LineType { horizontal, vertical, diagonal_ascending, diagonal_descending, none }

enum Winner { ai, player, draw, none }
