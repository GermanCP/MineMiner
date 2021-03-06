class Player {

  //movement via mouse has been removed!
  //movement via arrow-keys, mouse for interactions with UI etc.

  //variables for movement
  private PVector dir = new PVector(0, 0);
  private PVector newPos = new PVector();
  private PVector pos = new PVector();
  private PVector gridPos = new PVector();

  private Inventory inv;

  private int coins;

  private float r;
  private float speed = 3;

  //---------------------------------------------------------------------------
  //constructor  
  Player(float x_, float y_, float r_, int coins_) {
    this.pos.x = x_;
    this.pos.y = y_;

    this.inv = new Inventory();

    this.coins = coins_;
    this.r = r_;
  }

  //---------------------------------------------------------------------------
  //main method body
  void move(PVector arg) { //updating the players movement
    this.dir = arg;

    this.newPos.x = this.pos.x;
    this.newPos.y = this.pos.y;

    this.dir.setMag(speed);
    this.newPos.add(dir);

    if (checkCollision()) {
      //collision
    } else {
      //no collision
      this.pos.x = this.newPos.x;
      this.pos.y = this.newPos.y;
    }

    calcGridPos();
  }

  private boolean checkCollision() { //checks if player is colliding with anything
    if (checkBorders()) {
      return true;
    } else if (checkBoxes()) {
      return true;
    }
    return false;
  }

  //--------------------------------------------------------------------------------------------------
  //collision checking
  boolean checkBoxes() {    //detect whether any box is too close to the player and he is colliding
    for (Box b : mainMap.boxes) {
      if (this.newPos.dist(b.posM) <= r && b.type != 1) {
        return true;
      }
    }
    return false;
  }

  boolean checkBorders() {  //checking whether the player has reached the border of the screen, if so, pause movement in a certain direction
    if (this.newPos.x <= 0) {
      //left border reached 
      return true;
    }
    if (this.newPos.x >= width) {
      //right border reached
      return true;
    }
    if (this.newPos.y <= 0) {
      //upper border reached
      return true;
    }
    if (this.newPos.y >= height) {
      //lower border reached
      return true;
    }
    return false;
  }

  void calcGridPos() {
    this.gridPos.x = this.pos.x / tileSize;
    this.gridPos.y = this.pos.y / tileSize;
  }

  //---------------------------------------------------------------------------
  //shows player on screen
  void show() {  
    fill(255, 0, 0);
    stroke(0);
    ellipse(this.pos.x, this.pos.y, r, r);
  }
}