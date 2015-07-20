void whiteAI() {
  
  for (int x=0; x<8; x++) {
    for (int y=0; y<8; y++) {
      point[x][y] = 0;
    }
  }
  int p = 50;
  int posX = 0;
  int posY = 0;

  if (!myiro()) {

    for (int x=0; x<8; x++) {
      for (int y=0; y<8; y++) {
        checked[x][y] = false;

        a[0]=preCheck(x, y, -1, -1, 0);
        a[1]=preCheck(x, y, -1, 0, 0);
        a[2]=preCheck(x, y, -1, 1, 0);

        a[3]=preCheck(x, y, 0, -1, 0);
        a[4]=preCheck(x, y, 0, 1, 0);

        a[5]=preCheck(x, y, 1, -1, 0);
        a[6]=preCheck(x, y, 1, 0, 0);
        a[7]=preCheck(x, y, 1, 1, 0);
        if (a[0] || a[1] || a[2] || a[3] || a[4] || a[5] || a[6] || a[7]) {

          for (int dx=-1; dx<=1; dx++) {
            for (int dy=-1; dy<=1; dy++) {
              if (dx==0 && dy==0) continue;
              open_level(x, y, dx, dy, x, y);
            }
          }
        }
      }
    }

    for (int x=0; x<8; x++) {
      for (int y=0; y<8; y++) {
        if (p>=point[x][y] && point[x][y]!=0) {
          p = point[x][y];
          posX = x;
          posY = y;
        }
      }
    }

    field[posX][posY] = myColor();
    for (int a=-1; a<=1; a++) {
      for (int b=-1; b<=1; b++) {
        if (a==0 && b==0) continue;
        preCheck(posX, posY, a, b);
      }
    }
    return;
  }
  return;
}

void open_level(int x, int y, int dx, int dy, int sx, int sy) {
  if (x+dx<8 && x+dx>-1 && y+dy<8 && y+dy>-1) {
    if (field[x+dx][y+dy] != myColor() && field[x+dx][y+dy]!=GREEN && preCheck(x, y, dx, dy, 0)) {

      for (int aa=-1; aa<=1; aa++) {
        for (int bb=-1; bb<=1; bb++) {
          if (aa==0 && bb==0) continue;
          if (x+dx+aa<8 && x+dx+aa>-1 && y+dy+bb<8 && y+dy+bb>-1) {
            if (field[x+dx+aa][y+dy+bb]==NONE && checked[x+dx+aa][y+dy+bb] == false) {
              point[sx][sy]++;
              checked[x+dx+aa][y+dy+bb] = true;
            }
          }
        }
      }
      open_level(x+dx, y+dy, dx, dy, sx, sy);
    } else {
      return;
    }
  }
  return;
}

void set_table() {
  int black_sum = 0;
  int white_sum = 0;
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (field[i][j]==BLACK) black_sum++;
      if (field[i][j]==WHITE) white_sum++;
    }
  }
  if (sumcount != 64) {    
    table.addRow();
    table.setInt(turn_count, "turnNumber", turn_count);
    table.setInt(turn_count, "black", blackcount);
    table.setInt(turn_count, "white", whitecount);
    print(turn_count);
    print(" "+black_sum);
    println(":"+white_sum);
    turn_count++;
  }
}
