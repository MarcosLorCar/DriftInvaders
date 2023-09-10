class Player extends Entity{
  PImage hurtSprite, reloadedSprite, dieSprite, fHeartSprite, eHeartSprite;
  PImage[] fire = new PImage[2];;
  float acceleration, size, shootCD, bulletSpeed;
  boolean accelerating;
  int hurtTime, hits, lives;
  Player(Transform transform) {
    super(transform,loadImage("sprites/player_green.png"));
    reloadedSprite = loadImage("sprites/player_yellow.png");
    hurtSprite = loadImage("sprites/player_red.png");
    fire[0] = loadImage("sprites/fire1.png");
    fire[1] = loadImage("sprites/fire2.png");
    dieSprite = loadImage("sprites/die.png");
    eHeartSprite = loadImage("sprites/empty_heart.png");
    fHeartSprite = loadImage("sprites/full_heart.png");
    acceleration = 0.3;
    size = 25;
    accelerating = false;
    hurtTime = 0;
    shootCD = -20;
    bulletSpeed = 7;
    hits = 0;
    lives = 3;
  }
  
  void display() {
    pushMatrix();
    translate(transform.pos[0], transform.pos[1]);
    rotate(transform.rotation);
    if (accelerating) {
      if ((frameCount%20)<10) {
        image(fire[0], -30, 0);
      } else {
        image(fire[1], -30, 0);
      }
    }
    if(hurtTime>0) {
      if (frameCount%10<5) {
        image(sprite, 0, 0);
      } else {
        image(hurtSprite, 0, 0);
      }
      //rotate(-transform.rotation);
      rotate(PI/2);
      int hearts = lives - hits;
      for(int i = 0; i<lives ; i++) {
        if(hearts>0) {
          image(fHeartSprite,((1-lives)*100)+i*200,150);
          hearts--;
        } else {
          image(eHeartSprite,((1-lives)*100)+i*200,150);
        }
      }
      //rotate(transform.rotation);
      rotate(-PI/2);
      hurtTime--;
    } else {
      if(shootCD > -20 && shootCD <= 0) {
        image(reloadedSprite,0,0);
      } else {
        image(sprite, 0, 0);
      }
    }
    popMatrix();
  }

  void update() {
    float[] pos = transform.pos;
    float[] velocity = transform.velocity;
    transform.rotation = atan2((mouseY-pos[1]), (mouseX-pos[0]));
    
    //Interaction
    if (mousePressed) {
      switch(mouseButton) {
      case LEFT:
      velocity[0] *= drag;
      velocity[1] *= drag;
      accelerating = false;
        if(shootCD<=0) {
          shootCD = 180;
          newBullets.add(new Bullet(new Transform(new float[] {pos[0]+cos(transform.rotation)*25,pos[1]+sin(transform.rotation)*25}, transform.rotation, new float[] {cos(transform.rotation)*bulletSpeed,sin(transform.rotation)*bulletSpeed}), this));
        }
        break;
      case RIGHT:
        accelerating = true;
        float[] pointVec = new float[] {(mouseX - pos[0]), (mouseY - pos[1])};
        float[] pointVecNorm = new float[] {pointVec[0]/mag(pointVec[1], pointVec[0]), pointVec[1]/mag(pointVec[1], pointVec[0])};
        velocity[0] += pointVecNorm[0]*acceleration;
        velocity[1] += pointVecNorm[1]*acceleration;
        break;
      }
    } else {
      accelerating = false;
      velocity[0] *= drag;
      velocity[1] *= drag;
    }
    
    //Update CD
    if (shootCD > -20) {
      shootCD--;
    }

    //VELOCITY DEBUG
    //text(int(velocity[0])+" "+int(velocity[1])+"  vel: "+mag(velocity[0],velocity[1]),100,100);

    pos[0] += velocity[0];
    pos[1] += velocity[1];

    //Collision
    if (pos[0]-size<0) {
      pos[0] = size;
      velocity[0]*=-0.5;
    }
    if (pos[0]+size>width) {
      pos[0] = width-size;
      velocity[0]*=-0.5;
    }
    if (pos[1]-size<0) {
      pos[1] = size;
      velocity[1]*=-0.5;
    }
    if (pos[1]+size>height) {
      pos[1] = height-size;
      velocity[1]*=-0.5;
    }
  }
}
