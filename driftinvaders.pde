ArrayList<Entity> entities;
ArrayList<Bullet> newBullets;
ArrayList<Entity> dead;
float drag = 0.97;

void settings() {
  fullScreen();
}

void setup() {
  frameRate(60);
  strokeWeight(10);
  imageMode(CENTER);
  entities = new ArrayList();
  newBullets = new ArrayList();
  dead = new ArrayList();
  entities.add(new Player(new Transform(new float[]{width/2, height/2}, 0)));
}

void draw() {
  
  //Refresh
  background(0);
  
  //Add monsters
  if(frameCount%(80-(frameCount/240))==0) {
    float[] pos = new float[] {random(width+400)-200, random(height+400)-200};
    while((pos[0]>0 && pos[0]<width) && (pos[1]>0 && pos[1]<height)) {
      pos = new float[] {random(width+400)-200, random(height+400)-200};
    }
    entities.add(new Enemy(new Transform(pos,0)));
  }

  //Visuals
  for (Entity e : entities) {
    e.display();
  }

  //Phisics
  for (Entity e : entities) {
    e.update();
  }

  //Add bullets
  for (Bullet b : newBullets) {
    entities.add(b);
  }
  newBullets.clear();
  
  //Kill
  for (Entity e : dead) {
    entities.remove(e);
    if(e instanceof Player) {
      entities.add(0,new Corpse(new float[] {e.transform.pos[0],e.transform.pos[1]}));
    }
  }
  dead.clear();
}
