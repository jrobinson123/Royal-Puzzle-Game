



class Piece{
  int horzIndex;
  int vertIndex;
  
  float x;
  float y;
  int size;
  PImage sourceImage;
  PImage targetImage;
  boolean dragged = false;
  PVector mouseOffset;
  float angle;
  
  pieceType pt;
  Piece (int horzIndex, int vertIndex, int x, int y, int size, pieceType pt, PImage sourceImage) {
    this.horzIndex = horzIndex;
    this.vertIndex = vertIndex;
    this.x = x;
    this.y = y;
    this.size = size;
    this.pt = pt;
    this.sourceImage = sourceImage;
    mouseOffset = new PVector();
    targetImage = createImage(this.size, this.size, RGB);
    for (int i = int(this.x); i < this.x + size; i++) {
      for (int j = int(this.y); j < this.y + size; j++) {
          color pixelColor = this.sourceImage.get(i, j);
          targetImage.set(i - int(this.x), j - int(this.y), pixelColor);
      }
    }
    angle = int(random(4)) * 90;
    
  }
  
  void show() {
    pushMatrix();
    translate(x + size/2, y + size/2);
    //rotate(radians(angle));
    imageMode(CENTER);
    tint(255);
    image(targetImage, 0, 0);
    if (dragged) {
      fill(252, 230, 25, 100);
      rectMode(CENTER);
      rect(0, 0, size, size);
    }
    popMatrix();
  }
  
  boolean mouseHover() {
    return mouseX >= x && mouseX <= x + size && mouseY >= y && mouseY <= y + size;
  }
  
  void onPieceMousePressed(boolean usingLock) {
    if (this.mouseHover() && (!usingLock || board.anyDragged == false)) {
      mouseOffset.x = this.x - mouseX;
      mouseOffset.y = this.y - mouseY;
      this.dragged = true;
      if (usingLock) {
          board.anyDragged = true;
      }
    }
  }
  
  void onPieceMouseDragged() {
    if (dragged) {
      this.x = mouseX + mouseOffset.x;
      this.y = mouseY + mouseOffset.y;
    }
  }
  


  void onPieceMouseReleased() {
    if (this.dragged == true) {
      this.dragged = false;
      board.anyDragged = false;
      
      if (this.x < xDim * this.size) {
        this.x = int((this.x + size/2) / 100) * 100;
        this.y = int( (this.y + size/2) / 100) * 100;
      }
     }
 
  }
  
  int[] getIndices() {
    int[] indices = new int[2];
    indices[0] = this.horzIndex;
    indices[1] = this.vertIndex;
    return indices;
  }
  
  void randomizePosition() {
      this.x = int(random(xDim * size, width - size));
      this.y = int(random(325, height - size));
  }
  
  void checkForRotation () {
     if (this.mouseHover()) { 
       angle += 90;
       angle %= 360;
     }
  }
  
  void checkForDrag(Dragger dragger) {
      float startX = min(dragger.startX(), dragger.endX());
      float startY = min(dragger.startY(), dragger.endY());
      float endX =  max(dragger.startX(), dragger.endX());
      float endY  = max(dragger.startY(), dragger.endY());
      
      boolean xInRange =  !(endX < this.x || startX > this.x + size);
      boolean yInRange =  !(endY < this.y || startY > this.y + size);
      if (xInRange && yInRange) {
           mouseOffset.x = this.x - mouseX;
           mouseOffset.y = this.y - mouseY;
           this.dragged = true;
      }
  }

}
