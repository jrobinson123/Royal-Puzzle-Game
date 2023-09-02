


class Dragger {
  //selecting can be in three states: off, probing, dragging
  String selecting;
  float selectionStartX;      
  float selectionStartY;      
  float selectionEndX;      
  float selectionEndY; 
  
  
  Dragger(){
    selecting = "off";
    
  }
  
  void show() {
    if (selecting.equals("probing")) {
      noFill();
      stroke(0);
      rect(selectionStartX, selectionStartY, selectionEndX - selectionStartX, selectionEndY - selectionStartY);
    }
  }
  
  void update () {
     selectionEndX = mouseX;
     selectionEndY = mouseY;
  }
  
  void toggleProbing() {
    selectionStartX = mouseX;
    selectionStartY = mouseY;
    selecting = "probing";
  }
  
  void toggleDragging() {
    selecting = "dragging";
  }
  
  void toggleOff() {
    selecting = "off";
  }
  
  
  float startX() {
    return this.selectionStartX;
  }
  
  float startY() {
    return this.selectionStartY;
  }
  
  float endX() {
    return this.selectionEndX;
  }
  
  float endY(){
    return this.selectionEndY;
  }
  
  String selecting() {
    return selecting;
  }
}
