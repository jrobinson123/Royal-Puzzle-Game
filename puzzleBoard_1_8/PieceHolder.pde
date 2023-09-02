
 public enum pieceType {
    STANDARD,
    RIGHT,
    LEFT,
    TOP,
    BOTTOM,
    TOPRIGHT,
    BOTTOMRIGHT,
    TOPLEFT,
    BOTTOMLEFT,
}



class PieceHolders{
  boolean hide;
  PieceHolder[][] slots;
 
  PieceHolders() {
    this.hide = false;
    slots = new PieceHolder[xDim][yDim];
    for (int i = 0; i < xDim; i ++ ) {
      for (int j = 0; j < yDim; j ++ ) {
          slots[i][j] = new PieceHolder(i * 100, j * 100);
      }
    }
  }
  
  void hide() {
    this.hide = !this.hide;
  }
  
  void show () {
    if (hide == false) {
      for (PieceHolder[] s: slots) {
        for (PieceHolder ph: s) {
          ph.show();
        }
      }
    }
  }
}

class PieceHolder{
  int x; 
  int y; 
  
  PieceHolder(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void show () {
    noFill();
    stroke(255);
    strokeWeight(2);
    rectMode(CORNER);
    rect(x, y, 100, 100);
  }
}
