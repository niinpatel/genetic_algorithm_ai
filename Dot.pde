class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  boolean dead = false;
  float fitness = 0;
  boolean reachedGoal = false;
  boolean isBest = false;

  Dot () {
    brain = new Brain(brainSize);
    pos = new PVector (width/2, height - 50);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void show() {

    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  void move() {
    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else dead = true;
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }

  void update() {

    if (!dead && !reachedGoal) {
      move();
      dead = pos.x < 2 || pos.y < 2 || pos.x > width-2 || pos.y > height- 2;
      reachedGoal = (dist(pos.x, pos.y, goal.x, goal.y) < 5) ;
    } 

    for (Obstacle obstacle : obstacles) {
      if (obstacle.touched(pos)) dead = true;
    }
  }


  void calculateFitness() {
    if (reachedGoal) {
      fitness = 1.0/16.0 + 1000.0/(float)(brain.step * brain.step);
    } else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }

    for (Obstacle obstacle : obstacles) {
      if (obstacle.cleared(pos)) fitness *= 20;
    }
  }

  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}
