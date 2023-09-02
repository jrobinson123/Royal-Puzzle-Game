




class Board {
  ArrayList<Piece> pieces;
  int[] currentPieceSelected;
  int originX;
  int originY;
  int pieceSize = 100;
  PImage puzzleImage;
  boolean anyDragged;
  
  
  
  Board(int originX, int originY, PImage puzzleImage){
    this.originX = originX;
    this.originY = originY;
    this.puzzleImage = puzzleImage;
    pieces = new ArrayList<Piece>();
    
    for (int i = 0; i < xDim; i++) {
        for (int j = 0; j < yDim; j++) {
            int index = i * yDim + j;
            pieces.add(new Piece(i, j, i * pieceSize, j * pieceSize, pieceSize, generatePieceType(i, j), puzzleImage));
      }
    }
    
    for (Piece p: pieces) {
        p.randomizePosition();
    }
    
    currentPieceSelected = new int[2];
    currentPieceSelected[0] = xDim - 1;
    currentPieceSelected[1] = yDim - 1;
    
  }
  
  void show() {
    
   /* for (int i = 0; i < xDim; i++) {
      for (int j = 0; j < yDim; j++) {
        int index = i * yDim + j;
        pieces.get(i).show();
      }
    }
    */
    imageMode(CORNER);
    tint(100);
    image(puzzleImage, 700, 0, 700, 700); 
    
    for (int l = 0; l < pieces.size(); l++) {
      pieces.get(l).show();
    }
    
  }
  
  
  void boardMousePressed(boolean useLock) {
    boolean locked = false;
    for (int i = xDim - 1; i >= 0; i --) {
      for (int j = yDim - 1; j >= 0; j -- ) {
          int index = i * yDim + j;
          Piece p = pieces.get(index);
          p.onPieceMousePressed(useLock);
          if (p.mouseHover() && (!useLock || locked == false) ) {
              locked = true;
              pieces.add(pieces.remove(index));
        }
      }
    }
  }
  
  void checkForRotation() {
    for (Piece p: pieces) {
        p.checkForRotation();
    }
  }
  
  void boardMouseDragged() {
    for (Piece p: pieces) {
        p.onPieceMouseDragged();
    }
 }
  
  void boardMouseReleased() {
    for (Piece p: pieces) {
        p.onPieceMouseReleased();
    } 
 }
  
  pieceType generatePieceType (int i, int j) {
      if (i == 0) {
        if (j == 0) {
            return pieceType.TOPLEFT;
        } else if (j == yDim - 1) {
            return pieceType.BOTTOMLEFT;
        } else {
            return pieceType.STANDARD;
        }
      } else if (i == xDim - 1) {
        if (j == 0) {
            return pieceType.TOPRIGHT;
        } else if (j == yDim - 1) {
            return pieceType.BOTTOMRIGHT;
        } else {
            return pieceType.STANDARD;
        }
      } else if (j == 0) {
        return pieceType.TOP;
      } else if (j == yDim - 1) {
        return pieceType.BOTTOM;
      } else {
        return pieceType.STANDARD;
      }
  }
  
  int countDrags() {
    int count = 0;
    for (Piece p: pieces) {
        if (p.dragged == true) {
          count++;
        }  
    }
    return count;
  }
  
  void checkForDrags(Dragger dragger) {
    for (Piece p: pieces) {
       p.checkForDrag(dragger);
    }
    
  }
  
  
  ArrayList<Piece> Pieces(){
      return this.pieces;
  }
}
