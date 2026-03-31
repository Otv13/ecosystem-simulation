// ===== CLASS: PREDATOR =====
// Predator chases and eats prey

class Predator extends Organism {

  float detectionRange = 150; // How far predator can detect prey

  // ===== CONSTRUCTOR =====
  Predator(float x, float y) {
    super(x, y);
    size = 14; // Bigger than prey
  }

  // ===== UPDATE =====
  void update() {
    chasePrey(); // Try to find prey
    move();      // Then move
  }

  // ===== CHASE PREY =====
  void chasePrey() {

    Organism closest = null;
    float minDist = 99999;

    // Find closest prey
    for (Organism o : organisms) {
      if (o instanceof Prey) {

        float d = dist(x, y, o.x, o.y);

        // Only track prey within range
        if (d < minDist && d < detectionRange) {
          minDist = d;
          closest = o;
        }
      }
    }

    // Move toward closest prey
    if (closest != null) {

      float dx = closest.x - x;
      float dy = closest.y - y;
      float mag = sqrt(dx * dx + dy * dy);

      // Normalize direction
      if (mag > 0) {
        vx = dx / mag;
        vy = dy / mag;
      }

      // Eat prey if close enough
      if (minDist < 10) {
        organisms.remove(closest);
        return;
      }
    }
  }

  // ===== DISPLAY =====
  void display() {
    fill(255, 50, 50); // Red color
    noStroke();
    ellipse(x, y, size, size);
  }
}
