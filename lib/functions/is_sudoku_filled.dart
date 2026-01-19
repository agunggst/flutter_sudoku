bool isSudokuFilled(List<List<int>> board) {
  for (var i in board) {
    for (var j in i) {
      if (j == 0) {
        return false;
      }
    }
    
  }
  return true;
}