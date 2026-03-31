// ===== CLASS: PLANT =====
// Plants act as food for prey

class Plant {
  float x, y;      // Position
  float size = 6;  // Size of plant

  // ===== CONSTRUCTOR =====
  Plant(float x, float y) {
    this.x = x;
    this.y = y;
  }

  // ===== DISPLAY =====
  void display() {
    noStroke();
    fill(0, 200, 0); // Green color
    ellipse(x, y, size, size);
  }
}
