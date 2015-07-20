

/// type reverse
boolean preCheck(int x, int y, int dx, int dy) {
  if (checkEdge(x+dx, y+dy) && field[x+dx][y+dy] != myColor() && field[x+dx][y+dy]!=GREEN) {
    return reverser(x, y, dx, dy);
  }

  return false;
}


/// type check only
boolean preCheck(int x, int y, int dx, int dy, int reverse) {
  if (checkEdge(x+dx, y+dy) && field[x+dx][y+dy] != myColor() && field[x+dx][y+dy] != GREEN) {
    return check(x, y, dx, dy);
  }

  return false;
}
