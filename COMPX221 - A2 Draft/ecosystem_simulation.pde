// ===== GLOBALS =====
// Lists to store all organisms and plants in the simulation
ArrayList<Organism> organisms;
ArrayList<Plant> plants;

// This controls whether plants grow automatically over time
boolean plantGrowthEnabled = true;

// Used to pause and resume the simulation
boolean paused = false;

// ===== SLIDER (controls simulation speed) =====
// Position and size of the speed slider
float sliderX = 20;
float sliderY = 100;
float sliderW = 150;

// Value of the slider (affects movement speed)
float sliderValue = 1.0;

// Tracks if the slider is being dragged
boolean draggingSlider = false;


// ===== SETUP =====
void setup() {
  size(1280, 720); // Set window size (720p)
  initSimulation(); // Start the simulation
}


// ===== INITIALISE SIMULATION =====
void initSimulation() {
  // Create new lists (reset everything)
  organisms = new ArrayList<Organism>();
  plants = new ArrayList<Plant>();

  // Create some prey at random positions
  for (int i = 0; i < 20; i++) {
    organisms.add(new Prey(random(width), random(height)));
  }

  // Create some predators
  for (int i = 0; i < 5; i++) {
    organisms.add(new Predator(random(width), random(height)));
  }

  // Create starting plants
  for (int i = 0; i < 30; i++) {
    plants.add(new Plant(random(width), random(height)));
  }
}


// ===== MAIN DRAW LOOP =====
void draw() {
  // Draw background (green environment)
  background(30, 120, 70);

  // Only update simulation if not paused
  if (!paused) {
    updateSimulation();
  }

  // Draw everything
  drawSimulation();
  drawUI();
}


// ===== UPDATE SIMULATION =====
void updateSimulation() {

  // Update all organisms (movement, behaviour, etc.)
  for (int i = organisms.size() - 1; i >= 0; i--) {
    organisms.get(i).update();
  }

  // Automatically grow new plants over time (if enabled)
  if (plantGrowthEnabled && frameCount % 30 == 0) {
    plants.add(new Plant(random(width), random(height)));
  }
}


// ===== DRAW SIMULATION OBJECTS =====
void drawSimulation() {

  // Draw all plants
  for (Plant p : plants) {
    p.display();
  }

  // Draw all organisms (prey + predators)
  for (Organism o : organisms) {
    o.display();
  }
}


// ===== DRAW USER INTERFACE =====
void drawUI() {

  // Draw background panel for UI
  fill(0, 150);
  noStroke();
  rect(10, 10, 180, 210, 10);

  fill(255);
  textSize(14);

  // Labels for buttons and slider
  text("Pause", 20, 30);
  text("Reset", 20, 60);
  text("Speed: " + nf(sliderValue, 1, 2), 20, 90);

  // Draw buttons
  fill(200);
  rect(80, 15, 80, 20); // Pause button
  rect(80, 45, 80, 20); // Reset button

  // Button text
  fill(0);
  text(paused ? "Play" : "Pause", 90, 30);
  text("Reset", 90, 60);

  // ===== SLIDER =====
  // Draw slider line
  stroke(255);
  line(sliderX, sliderY, sliderX + sliderW, sliderY);

  // Draw slider knob
  float knobX = sliderX + sliderValue * sliderW;
  fill(255);
  ellipse(knobX, sliderY, 10, 10);

  // ===== CHECKBOX (Plant Growth Toggle) =====
  fill(255);
  text("Plant Growth", 20, 130);

  // Draw checkbox box
  stroke(255);
  noFill();
  rect(120, 120, 15, 15);

  // Draw X inside checkbox if enabled
  if (plantGrowthEnabled) {
    line(120, 120, 135, 135);
    line(135, 120, 120, 135);
  }

  // ===== POPULATION COUNTERS =====
  // Show how many organisms/plants are in the simulation
  fill(255);
  text("Prey: " + countPrey(), 20, 160);
  text("Predators: " + countPredators(), 20, 180);
  text("Plants: " + plants.size(), 20, 200);
}


// ===== MOUSE INPUT =====
void mousePressed() {

  // Pause or resume simulation
  if (overRect(80, 15, 80, 20)) {
    paused = !paused;
  }

  // Toggle plant growth on/off
  if (overRect(120, 120, 15, 15)) {
    plantGrowthEnabled = !plantGrowthEnabled;
  }

  // Reset everything
  if (overRect(80, 45, 80, 20)) {
    initSimulation();
  }

  // Check if user clicked the slider knob
  float knobX = sliderX + sliderValue * sliderW;
  if (dist(mouseX, mouseY, knobX, sliderY) < 10) {
    draggingSlider = true;
  }

  // Add a plant where the user clicks (if not clicking UI)
  if (!overRect(10, 10, 180, 210)) {
    plants.add(new Plant(mouseX, mouseY));
  }
}


// ===== SLIDER DRAG =====
void mouseDragged() {
  // Move slider when dragging
  if (draggingSlider) {
    sliderValue = constrain((mouseX - sliderX) / sliderW, 0, 2);
  }
}


// ===== RELEASE MOUSE =====
void mouseReleased() {
  draggingSlider = false; // Stop dragging slider
}


// ===== HELPER: CHECK IF MOUSE OVER RECT =====
boolean overRect(float x, float y, float w, float h) {
  return mouseX > x && mouseX < x + w &&
         mouseY > y && mouseY < y + h;
}


// ===== COUNT PREY =====
// Counts how many prey are in the simulation
int countPrey() {
  int count = 0;
  for (Organism o : organisms) {
    if (o instanceof Prey) count++;
  }
  return count;
}


// ===== COUNT PREDATORS =====
// Counts how many predators are in the simulation
int countPredators() {
  int count = 0;
  for (Organism o : organisms) {
    if (o instanceof Predator) count++;
  }
  return count;
}
