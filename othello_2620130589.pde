
//スペースキーでパス,ｚキーでUNDO,UNDOは１回まで
final int SIZE = 50;
final int STONE_SIZE = (int)(SIZE*0.7);
final int NONE = 0;
final int BLACK = 1;
final int WHITE = 2;
final int GREEN = 3;


Table table;
int[][] field;
boolean[] a;
int[][] prefield=new int[8][8];

boolean black_turn = true;
int blackcount, whitecount, sumcount;
int menuHeight=90;
//open level
boolean checked[][] = new boolean[8][8];
int point[][] = new int[8][8];
int turn_count = 1;
//初回処理変数
int colorsentaku=0;
//endsyorihensuu
int pasuNoKaisuu=0;

void setup() {
  size(8*SIZE, 8*SIZE+menuHeight);
  field = new int[8][8];
  a= new boolean[8];
  for (int i=0; i<8; ++i) {
    for (int j=0; j<8; ++j) {
      field[i][j] = NONE;
    }
  }
  field[3][3] = BLACK;
  field[4][4] = BLACK;
  field[3][4] = WHITE;
  field[4][3] = WHITE;
  field[3][5] = GREEN;
  field[2][4] = GREEN;
  field[4][2] = GREEN;
  field[5][3] = GREEN;



  blackcount=2;
  whitecount=2;
  table = new Table();
  table.addColumn("turnNumber", Table.INT);
  table.addColumn("black", Table.INT);
  table.addColumn("white", Table.INT);
  table.addRow();
  table.setInt(0, "turnNumber", 0);
  table.setInt(0, "black", 2);
  table.setInt(0, "white", 2);
}

void draw() {
  background(0, 128, 0);
  // lines
  stroke(0);
  for (int i=1; i<8; ++i) {
    line(i*SIZE, 0, i*SIZE, height);
    line(0, i*SIZE, width, i*SIZE);
  }
  //hooder
  hooder();
  //hodder sumnumber  
  blackcount=0;
  whitecount=0;

  for (int i=0; i<8; ++i) {
    for (int j=0; j<8; ++j) {
      if (field[i][j]==BLACK) blackcount++;
      if (field[i][j]==WHITE) whitecount++;
      if (field[i][j]==GREEN) field[i][j]=NONE;
    }
  }
  sumcount=blackcount+whitecount;
  //緑を描く
  if (myiro()) {
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        if (field[i][j]== NONE) {
          a[0]=preCheck(i, j, -1, -1, 0);
          a[1]=preCheck(i, j, -1, 0, 0);
          a[2]=preCheck(i, j, -1, 1, 0);

          a[3]=preCheck(i, j, 0, -1, 0);
          a[4]=preCheck(i, j, 0, 1, 0);

          a[5]=preCheck(i, j, 1, -1, 0);
          a[6]=preCheck(i, j, 1, 0, 0);
          a[7]=preCheck(i, j, 1, 1, 0);
          if (a[0] || a[1] || a[2] || a[3] || a[4] || a[5] || a[6] || a[7]) {
            field[i][j] = GREEN;
          }
        }
      }
    }
  }
  ///whiteAI 
  if (!myiro() && colorsentaku!=0) {
    whiteAI();
    set_table();
    black_turn = !black_turn;
  }

  // draw stones
  noStroke();
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {


      if (field[i][j]==BLACK) {
        fill(0);  //color black
        ellipse((i*2+1)*SIZE/2, (j*2+1)*SIZE/2, STONE_SIZE, STONE_SIZE);
      } else if (field[i][j]==WHITE) {
        fill(255); // color white
        ellipse((i*2+1)*SIZE/2, (j*2+1)*SIZE/2, STONE_SIZE, STONE_SIZE);
      } else if (field[i][j]==GREEN) {
        fill(0, 250, 154);
        ellipse((i*2+1)*SIZE/2, (j*2+1)*SIZE/2, 0.7*STONE_SIZE, 0.7*STONE_SIZE);
      }
    }
  }
  //初ターン、白か黒を選択
  if (colorsentaku==0) {
    fill(0);
    ellipse(2*SIZE, 4*SIZE, 150, 150);
    fill(255);
    ellipse(6*SIZE, 4*SIZE, 150, 150);
  }
}

boolean myiro() {
  if (colorsentaku==BLACK) {
    return black_turn;
  } else if (colorsentaku==WHITE) {
    return !black_turn;
  }
  return false;
}

void mousePressed() {
  int x = mouseX/SIZE;
  int y = mouseY/SIZE;

  //初ターン城か黒かを選択
  if (colorsentaku==0) {
    if (dist(2*SIZE, 4*SIZE, mouseX, mouseY)<150) {
      colorsentaku=BLACK;
    } else if (dist(6*SIZE, 4*SIZE, mouseX, mouseY)<150) {
      colorsentaku=WHITE;
    }
  }

  //盤面を記憶
  for (int i=0; i < 8; i++) {
    for (int j=0; j <8; j++) {
      prefield[i][j]=field[i][j];
    }
  }

  //周囲探索して１つでもいけたらひっくり返す
  if (field[x][y]==NONE || field[x][y]==GREEN) {
    a[0]=preCheck(x, y, -1, -1);
    a[1]=preCheck(x, y, -1, 0);
    a[2]=preCheck(x, y, -1, 1);

    a[3]=preCheck(x, y, 0, -1);
    a[4]=preCheck(x, y, 0, 1);

    a[5]=preCheck(x, y, 1, -1);
    a[6]=preCheck(x, y, 1, 0);
    a[7]=preCheck(x, y, 1, 1);

    if (a[0] || a[1] || a[2] || a[3] || a[4] || a[5] || a[6] || a[7]) {

      if (black_turn) {
        field[x][y] = BLACK;
        black_turn = !black_turn;
      } else {
        field[x][y] = WHITE;
        black_turn = !black_turn;
      }
    }
  }

  //hodder sumnumber  
  blackcount=0;
  whitecount=0;
}

void keyPressed() {
  switch(key) {
  case ' ':
    black_turn= !black_turn;
    pasuNoKaisuu++;
    //endsyori
    if (pasuNoKaisuu==2) {
      sumcount=64;
    }
    break;

  case 'z':
    //記憶した盤面の呼び起こし
    for (int i=0; i < 8; i++) {
      for (int j=0; j <8; j++) {
        field[i][j]=prefield[i][j];
      }
    }
    break;
  }
}
