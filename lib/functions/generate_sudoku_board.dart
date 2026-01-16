// sudoku_generator_unique.dart
// Full Sudoku Generator with Unique Solution
// 0 = empty

// ================= VALIDATION =================

bool _isValid(List<List<int>> board, int row, int col, int num) {
  for (int i = 0; i < 9; i++) {
    if (board[row][i] == num || board[i][col] == num) return false;
  }

  int startRow = (row ~/ 3) * 3;
  int startCol = (col ~/ 3) * 3;

  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      if (board[startRow + r][startCol + c] == num) return false;
    }
  }

  return true;
}

// ================= SOLVER =================

bool solveSudoku(List<List<int>> board) {
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (board[row][col] == 0) {
        for (int num = 1; num <= 9; num++) {
          if (_isValid(board, row, col, num)) {
            board[row][col] = num;
            if (solveSudoku(board)) return true;
            board[row][col] = 0;
          }
        }
        return false;
      }
    }
  }
  return true;
}

// ================= COUNT SOLUTIONS =================

int countSolutions(List<List<int>> board) {
  int count = 0;
  _solveAndCount(board, () {
    count++;
  });
  return count;
}

bool _solveAndCount(List<List<int>> board, Function onSolutionFound) {
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (board[row][col] == 0) {
        for (int num = 1; num <= 9; num++) {
          if (_isValid(board, row, col, num)) {
            board[row][col] = num;

            if (_solveAndCount(board, onSolutionFound)) {
              return true;
            }

            board[row][col] = 0;
          }
        }
        return false;
      }
    }
  }

  onSolutionFound();
  return false;
}

// ================= FULL BOARD GENERATOR =================

bool _fillBoard(List<List<int>> board) {
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (board[row][col] == 0) {
        List<int> numbers = List.generate(9, (i) => i + 1)..shuffle();

        for (int num in numbers) {
          if (_isValid(board, row, col, num)) {
            board[row][col] = num;
            if (_fillBoard(board)) return true;
            board[row][col] = 0;
          }
        }
        return false;
      }
    }
  }
  return true;
}

// ================= HELPERS =================

List<List<int>> _copyBoard(List<List<int>> board) {
  return board.map((row) => List<int>.from(row)).toList();
}

// ================= UNIQUE GENERATOR =================

List<List<int>> generateUniqueSudoku({int clues = 30}) {
  List<List<int>> board = List.generate(9, (_) => List.filled(9, 0));

  _fillBoard(board);

  List<(int, int)> cells = [];
  for (int r = 0; r < 9; r++) {
    for (int c = 0; c < 9; c++) {
      cells.add((r, c));
    }
  }

  cells.shuffle();

  for (var (row, col) in cells) {
    int backup = board[row][col];
    board[row][col] = 0;

    var copy = _copyBoard(board);
    int solutions = countSolutions(copy);

    if (solutions != 1) {
      board[row][col] = backup;
    }

    int filled = board.expand((e) => e).where((e) => e != 0).length;
    if (filled <= clues) break;
  }

  return board;
}

// ================= DIFFICULTY =================

List<List<int>> generateSudokuByDifficulty(String level) {
  switch (level) {
    case 'easy':
      return generateUniqueSudoku(clues: 42);
    case 'medium':
      return generateUniqueSudoku(clues: 34);
    case 'hard':
      return generateUniqueSudoku(clues: 28);
    case 'expert':
      return generateUniqueSudoku(clues: 24);
    default:
      return generateUniqueSudoku(clues: 34);
  }
}

// ================= DEMO =================

void printBoard(List<List<int>> board) {
  for (var row in board) {
    print(row);
  }
}

void main() {
  var board = generateSudokuByDifficulty('medium');
  printBoard(board);
}
