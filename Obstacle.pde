class Obstacle {

  int x, y, w, h;

  Obstacle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void show() {
    fill(0, 0, 255);
    rect(x, y, w, h);
  }

  boolean touched(PVector pos) {
    boolean touchedObstacle = pos.x <= (x + w) && pos.y <= (y + h) && pos.x >= x && pos.y >= y;
    return touchedObstacle;
  }

  boolean cleared(PVector pos) {
    return (y >= pos.y);
  }
}
