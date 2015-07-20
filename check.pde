boolean check(int x, int y, int dx, int dy) { //<>//
  if (checkEdge(x+dx, y+dy) && field[x+dx][y+dy]==myColor()) {
    return true;
  } else if (checkEdge(x+dx, y+dy) &&( field[x+dx][y+dy]==NONE || field[x+dx][y+dy]==GREEN)) {
    return false;
  } else if (checkEdge(x+dx, y+dy) && check(x+dx, y+dy, dx, dy)) {
    return true;
  } else {
    return false;
  }
}

int myColor() {
  if (black_turn) {
    return BLACK;
  } else {
    return WHITE;
  }
}

boolean checkEdge(int x, int y) {
  if (x>=0 && x<8 && y>=0 && y<8) {
    return true;
  }
  return false;
}
