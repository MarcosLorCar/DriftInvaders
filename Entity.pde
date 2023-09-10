abstract class Entity {
  Transform transform;
  PImage sprite;
  Entity(Transform transform,PImage sprite) {
    this.transform = transform;
    this.sprite = sprite;
  }
  abstract void display();
  abstract void update();
}
