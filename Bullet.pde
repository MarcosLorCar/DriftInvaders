class Bullet extends Entity {
  Player owner;
  Bullet(Transform transform, Player owner) {
    super(transform,loadImage("sprites/bullet.png"));
    this.owner = owner;
  }
  
  void display() {
    pushMatrix();
    translate(transform.pos[0], transform.pos[1]);
    rotate(transform.rotation);
    image(sprite,0,0);
    popMatrix();
  }
  
  void update() {
    float[] pos = transform.pos;
    float[] velocity = transform.velocity;
    pos[0] += velocity[0];
    pos[1] += velocity[1];
    
    if(pos[0]<0||pos[0]>width||pos[1]<0||pos[1]>height) {
      dead.add(this);
    }
  }
}
