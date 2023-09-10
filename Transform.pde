class Transform {
  float[] pos;
  float rotation;
  float[] velocity;
  Transform() {}
  Transform(float[] pos, float rotation) {
    this.pos = pos;
    this.rotation = rotation;
    velocity = new float[2];
  }
  Transform(float[] pos, float rotation, float[] velocity) {
    this.pos = pos;
    this.rotation = rotation;
    this.velocity = velocity;
  }
}
