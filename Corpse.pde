class Corpse extends Entity {
  Corpse(float[] pos) {
    super(new Transform(pos, 0), loadImage("sprites/die.png"));
  }
  void display() {
    image(sprite,transform.pos[0],transform.pos[1]);
  }
  void update() {}
}
