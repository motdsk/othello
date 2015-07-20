boolean reverser(int x, int y, int dx, int dy) {
  if (checkEdge(x+dx, y+dy) && field[x+dx][y+dy]==myColor()) {
    return true;
  } else if (checkEdge(x+dx, y+dy) && (field[x+dx][y+dy]==NONE || field[x+dx][y+dy]==GREEN)) {
    return false;
  } else if (checkEdge(x+dx, y+dy) && reverser(x+dx, y+dy, dx, dy)) {
    field[x+dx][y+dy]=myColor();
    pasuNoKaisuu=0;
    return true;
  } else {
    return false;
  }
}
