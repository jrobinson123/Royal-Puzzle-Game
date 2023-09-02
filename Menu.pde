

class Menu {
  
  menuSegment[] menuSegments;
  
  int size = 200;
  int centeringOffsetX;
  int centeringOffsetY;
  
  boolean opened;
  
  Menu(PImage... input_images) {
    menuSegments = new menuSegment[input_images.length];
    
    
    int count = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
          menuSegments[count] = new menuSegment(input_images[count], i * (size + size/4) + 700, j * (size + size/4), size, size);
          count++;
      }
    }
    opened = true;
  }
  
  boolean opened() {
    return this.opened;
  }
  
  PImage checkForClick() {
    PImage imageToReturn = null;
    for (menuSegment m: menuSegments) {
        if (m.mouseHover()) {
          imageToReturn = m.getBaseImage();
          opened = false;
        }
    }
    return imageToReturn;
  }
  
  void show () {
    textSize(70);
    text("Choose Your Puzzle", 90, 300);
      for (menuSegment m: menuSegments) {
        m.show();
      }
  }
}

class menuSegment {
  PImage base;
  int x;
  int y;
  int xSize;
  int ySize;
  
  menuSegment (PImage image, int x, int y, int xSize, int ySize) {
      base = image;
      this.x = x;
      this.y = y;
      this.xSize = xSize;
      this.ySize = ySize;
  }
  
  boolean mouseHover() {
    return mouseX >= x && mouseX <= this.x + this.xSize && mouseY >= this.y && mouseY <= this.y + this.ySize;
  }
  
  void show() {
    image(this.base, this.x, this.y, this.xSize, this.ySize);
  }
  
  PImage getBaseImage(){
    return this.base;
  }
}
