bool validateSudokuBoard(List<List<int>> board) {
  // Check rows
  for (var row in board) {
    if (!_checkNumber(row)) return false;
  }

  // Check columns
  for (int col = 0; col < 9; col++) {
    List<int> column = [];
    for (int row = 0; row < 9; row++) {
      column.add(board[row][col]);
    }
    if (!_checkNumber(column)) return false;
  }

  // Check 3x3 squares
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      int startRow = i * 3;
      int startCol = j * 3;

      List<int> square = [];

      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          square.add(board[startRow + r][startCol + c]);
        }
      }

      if (!_checkNumber(square)) return false;
    }
  }

  return true;
}

bool _checkNumber(List<int> list) {
  if (list.length != 9) return false;
  if (list.contains(0)) return false;

  List<int> ref = List.generate(9, (i) => i + 1);
  List<int> sorted = List.from(list)..sort();

  for (int i = 0; i < 9; i++) {
    if (sorted[i] != ref[i]) {
      return false;
    }
  }

  return true;
}
