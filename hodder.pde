//drawhooder

void hooder() {

  fill(218, 165, 32);
  rect(0, height-menuHeight, width, menuHeight);
  fill(205, 0, 0);
  textSize(20);
  text("VS", width/2-10, height-menuHeight/4);
  ///draw winner
  if (sumcount == 64) {
    if (blackcount>whitecount) text("WINNER", width/4-25, height-3*menuHeight/4);
    if (blackcount<whitecount) text("WINNER", 3*width/4-25, height-3*menuHeight/4);
    if (blackcount==whitecount) text("hiiwake", width/2-25, height-3*menuHeight/4);
    ///draw result
    saveTable(table, "data/process.csv");
    noLoop();
  } else if (black_turn) {
    beginShape();
    vertex(width/4, height-3*menuHeight/4);
    vertex(width/4-13*sin(radians(3*frameCount)), height-3*menuHeight/4-15);
    vertex(width/4, height-3*menuHeight/4-10);
    vertex(width/4+13*sin(radians(3*frameCount)), height-3*menuHeight/4-15);
    endShape();
  } else {
    beginShape();
    vertex(3*width/4, height-3*menuHeight/4);
    vertex(3*width/4-10*sin(radians(3*frameCount)), height-3*menuHeight/4-15);
    vertex(3*width/4, height-3*menuHeight/4-10);
    vertex(3*width/4+10*sin(radians(3*frameCount)), height-3*menuHeight/4-15);
    endShape();
  }

  fill(0);
  text("black", width/4-25, height-3*menuHeight/4+20);
  text(blackcount, width/4-10, height-3*menuHeight/4+40);
  fill(255);
  text("white", 3*width/4-25, height-3*menuHeight/4+20);
  text(whitecount, 3*width/4-10, height-3*menuHeight/4+40);
}
