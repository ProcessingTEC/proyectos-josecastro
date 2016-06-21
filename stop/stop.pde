/**
 * STOP. 
 *
 * Seleccion automatica de la letra para jugar stop. 
 */

PFont f;
int letter = 0;
boolean[] played;
int randomLetter;
boolean stop;

void setup() {
  size(640, 360);
  background(0);

  // Create the font
  f = createFont("SourceCodePro-Regular.ttf", 64);
  textFont(f);
  textAlign(CENTER, CENTER);

  stop = false;
  played = new boolean[30];
  for (int i = 0; i < 30; i++)
    played[i] = false;
}

void draw() {
  if (frameCount % 6 == 0 && !stop) {
    background(255);

    // Set the left and top margin
    int margin = 10;
    int marginX = 18;
    translate(margin*4+marginX, margin*4);

    int gap = 88;
    int counter = 65;

    fill(0);
    for (randomLetter = floor(random(26)); 
      played[randomLetter]; )
      randomLetter = floor(random(26));

    for (int y = 0; y < height-gap; y += gap) {
      for (int x = 0; x < width-gap; x += gap) {

        char letter = (counter < 91 ? char(counter) : ' ');

        if (counter == 65+randomLetter) {
          fill(0, 255, 0); 
          stroke(0, 255, 0);
        } else if (played[counter-65]) {
          fill(196); 
          stroke(196);
        } else {
          fill(0); 
          stroke(0);
        }

        // Draw the letter to the screen
        text(letter, x, y);

        // Increment the counter
        counter++;
      }
    }
  }
}

void keyPressed() {
  if (stop) played[randomLetter] = true;
  stop = !stop;
}