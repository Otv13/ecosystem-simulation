// ===== CLASS: PREY =====
//Note that the code needs to be read through and understand how it works for improvement and developer clarifications
// Prey moves around and eats plants

class Prey extends Organism {

  // ===== CONSTRUCTOR =====
  Prey(float x, float y) {
    super(x, y);
    size = 8; // Smaller than predator
  }

  // ===== UPDATE =====
  void update() {
    eatPlants(); // Look for food
    move();      // Move around
  }

  // ===== EAT PLANTS =====
  void eatPlants() {

    // Loop backwards so we can remove safely
    for (int i = plants.size() - 1; i >= 0; i--) {

      Plant p = plants.get(i);

      // If close enough, remove plant (eat it)
      if (dist(x, y, p.x, p.y) < 10) {
        plants.remove(i);
      }
    }
  }

  // ===== DISPLAY =====
  void display() {
    fill(0, 200, 255); // Blue color
    noStroke();
    ellipse(x, y, size, size);
  }
}
