class Enemy extends Entity {
  PImage spriteWalk;
  float size;
  float knockbackMult;
  float velocity;
  Enemy(Transform transform) {
    super(transform, loadImage("sprites/enemy1.png"));
    spriteWalk = loadImage("sprites/enemy2.png");
    size = 30;
    knockbackMult = 10;
    velocity = 2.5;
  }

  void display() {
    if (frameCount%20<10) {
        image(sprite, transform.pos[0], transform.pos[1]);
      } else {
        image(spriteWalk, transform.pos[0], transform.pos[1]);
      }
  }

  void update() {
    float[] pos = transform.pos;
    //Collisions
    for (Entity e : entities) {
      if ((e instanceof Player) && colliding((Player) e)) {
        Player p = (Player) e;
        if (p.hurtTime!=0) {
          continue;
        }
        float[] opos = p.transform.pos;
        float[] knockback = new float[] {(opos[0]-pos[0])/dist(pos[0], pos[1], opos[0], opos[1]), (opos[1]-pos[1])/dist(pos[0], pos[1], opos[0], opos[1])};
        p.transform.velocity[0] = knockback[0]*knockbackMult;
        p.transform.velocity[1] = knockback[1]*knockbackMult;
        p.hurtTime = 90;
        p.hits++;
        if(p.hits>=p.lives) {
          dead.add(p);
        }
      } else if ((e instanceof Bullet) && (pdist(e)<size)) {
        Bullet b = (Bullet) e;
        b.transform.pos[0] = width*2;
        dead.add(b);
        dead.add(this);
        b.owner.shootCD = 0;
      }
    }

    //Pathfind
    Player objective = null;
    for (Entity e : entities) {
      if (e instanceof Player) {
        Player p = (Player) e;
        if (objective == null) {
          objective = p;
        } else {
          if ((pdist(p))<(pdist(objective))) {
            objective = p;
          }
        }
      }
    }
    if (!(objective == null)) {
      pos[0] += ((objective.transform.pos[0]-pos[0])/pdist(objective))*velocity;
      pos[1] += ((objective.transform.pos[1]-pos[1])/pdist(objective))*velocity;
    }
  }

  float pdist(Entity p) {
    return dist(p.transform.pos[0], p.transform.pos[1], transform.pos[0], transform.pos[1]);
  }

  boolean colliding(Player p) {
    Transform t = transform;
    Transform ot = p.transform;
    if (dist(t.pos[0], t.pos[1], ot.pos[0], ot.pos[1])<(size+p.size)) {
      return true;
    } else ;
    return false;
  }
}
