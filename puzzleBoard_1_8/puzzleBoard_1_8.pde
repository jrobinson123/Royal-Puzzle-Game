

PImage cyberpunk;


PImage lion;
PImage cuba;
PImage mission;
PImage casino;
PImage lowrider;
PImage la_jolla;
PImage ancient_city;
PImage jerusalem;
PImage morocco;

PImage table;


int xDim = 7;
int yDim = 7;

PFont OldLondon;
PImage usedImage;

Dragger dragger;


Menu menu;
Board board;

PieceHolders pieceHolders;
void setup(){
  size(1400,700);
  cyberpunk = loadImage("cyberpunkpuzzleimage.png");
  loadImages();
  table = loadImage("japanese_red_wood.png");
  table.resize(700, 700);
 // cyberpunk.resize(700, 700);
 
  menu = new Menu(lion, cuba, mission, casino, la_jolla, lowrider, ancient_city, jerusalem, morocco);
  
  pieceHolders = new PieceHolders();
  

  // The font must be located in the sketch's 
  // "data" directory to load successfully
  OldLondon = createFont("Olondon_.otf", 128);
  dragger = new Dragger();
  textFont(OldLondon);
 
}

void draw(){
  imageMode(CORNER);
  rectMode(CORNER);
  if (menu.opened() == false) {
    println(dragger.selecting());
    background(51);
    rectMode(CORNER);
    image(table, 700, 0);
       
    board.show();
    pieceHolders.show();
    
     if (dragger.selecting().equals("dragging")) {
        println("reachedddddddd");
        board.boardMouseDragged();
    }
    
    textAlign(LEFT, TOP);
    textSize(70);
    fill(0);
    text("Royal Puzzle", 720, 50);
    if (dragger.selecting().equals("probing")) {
        dragger.show();
    }
    
   
  } else {
    background(57, 96, 125);
    menu.show(); 
  }
}



void initializeBoard (PImage image) {
  board = new Board(0, 0, image);
}


void keyPressed() {
  if (key == 'j') {
    pieceHolders.hide();
  }
  if (key == 'r') {
    board.checkForRotation();
  }
}


void mousePressed() {
  if (menu.opened() == false) {
    if (keyPressed && key == 'd' && dragger.selecting().equals("off")) {
        dragger.toggleProbing();
    } else if (dragger.selecting().equals("dragging")) {
        board.boardMouseReleased();
    }else {
        board.boardMousePressed(true);
    }
  } else {
    PImage temp = menu.checkForClick();
    if (temp != null) {
      initializeBoard(temp);
    }
  }
  
}


void mouseDragged() {
  
  
  if (board != null) {
    if (dragger.selecting().equals("probing")) {
       dragger.update();
    } else {
      board.boardMouseDragged();
    }
  }
}


void mouseReleased() {
  if (board != null) {
    if (dragger.selecting().equals("probing")) {
       dragger.toggleDragging();
       board.checkForDrags(dragger);
    } else if (dragger.selecting().equals("dragging")) {
       dragger.toggleOff();
    }else {
      board.boardMouseReleased();
    } 
  }
}
