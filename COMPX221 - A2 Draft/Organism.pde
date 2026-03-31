// ===== BASE CLASS: ORGANISM =====
// This is the parent class for all moving creatures (Prey + Predator)

class Organism {
  float x, y;      // Position on screen
  float vx, vy;    // Movement direction (velocity)
  float size = 10; // Default size

  // ===== CONSTRUCTOR =====
  Organism(float x, float y) {
    this.x = x;
    this.y = y;

    // Give random movement direction at start
    vx = random(-1, 1);
    vy = random(-1, 1);
  }

  // ===== MOVEMENT =====
  void move() {
    // Move based on velocity and speed slider
    x += vx * sliderValue;
    y += vy * sliderValue;

    // Bounce off screen edges
    if (x < 0 || x > width) {
      vx *= -1;
    }

    if (y < 0 || y > height) {
      vy *= -1;
    }

    // Keep inside screen
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  // ===== UPDATE =====
  // Runs every frame
  void update() {
    move();
  }

  // ===== DISPLAY =====
  void display() {
    fill(255); // Default white
    noStroke();
    ellipse(x, y, size, size);
  }
}
