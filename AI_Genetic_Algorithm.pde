Population population;
PVector goal = new PVector(400, 10);
Obstacle[] obstacles = new Obstacle[5];
int brainSize = 3000;
boolean paused = false;
int populationSize = 3000;
float mutationRate = 0.01;

void setup() {
  size(800, 800);
  population = new Population(populationSize);
  obstacles[0] = new Obstacle(200, 200, 400, 10);
  obstacles[1] = new Obstacle(200, 600, 400, 10);

  obstacles[2] = new Obstacle(0, 300, 500, 10);
  obstacles[3] = new Obstacle(300, 400, 500, 10);
  obstacles[4] = new Obstacle(0, 500, 500, 10);
}

void keyPressed() {
  if (key == ' ') { 
    if (paused)loop(); 
    else {
      noLoop();
    }
    paused = !paused;
  }
}


void draw() {
  background(255);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  for (Obstacle obstacle : obstacles) {
    obstacle.show();
  }

  textSize(15);
  fill(0);
  text("Generation: " + population.gen, 650, 20);
  text("Minimum Steps " + population.minStep, 600, 40);
  if (population.allDotsDead()) {
    // genetic algorithm
    population.calculateFitness();
    population.naturalSelection();
    population.mutateDemBabies();
  } else {
    population.update();
    population.show();
  }
}
