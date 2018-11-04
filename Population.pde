class Population {

  Dot[] dots; 
  float fitnessSum = 0;
  int gen = 0;
  int bestDot;
  int minStep = brainSize;

  Population   (int size) {

    dots = new Dot[size];
    for (int i = 0; i < size; i++) {
      dots[i] = new Dot();
    }
  }

  void printCDs() {
    for (int i = 0; i < dots.length; i++) {
      println( dots[i].pos.x, dots[i].pos.y);
    }
  }

  void show() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].show();
    }
  }

  void update() {
    for (int i = 0; i < dots.length; i++) {
      if (dots  [i].brain.step > minStep ) {
        dots[i].dead = true;
      } else dots[i].update();
    }
  }

  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }

  boolean allDotsDead() {
    for (int i = 0; i < dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }


    return true;
  }


  void naturalSelection () {
    Dot[] newDots = new Dot[dots.length];
    calculateFitnessSum();
    setBestDot();
    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for (int i = 1; i< newDots.length; i++) {
      // select parent based on fitness
      Dot parent = selectParent();
      // get baby from them
      Dot newDot = parent.gimmeBaby();
      newDots[i] = newDot;
    }
    dots = newDots.clone();  
    gen++;
  }

  void calculateFitnessSum() {

    for (int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }

  Dot selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;
    for (int i = 0; i < dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum > rand) {
       return dots[i];
      }
    }
    
    return dots[floor(random(dots.length))];
  }

  void mutateDemBabies() {

    for (int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }

  void setBestDot() {
    float max = 0;
    int maxI = 0;
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxI = i;
      }
    }
    bestDot = maxI;

    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
    }
  }
}
