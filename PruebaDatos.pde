import controlP5.*;

ControlP5 cvMax;
ControlP5 cvMin;

BufferedReader reader;
String line;

int R=1;//6371;//radio de la tierra en km

float[] x;
float[] y;
float[] speed;
float[] air;

int size;
int VelocidadMax = 15;
int VelocidadMin;

float maxX, minX, maxY, minY;
float maxAir, minAir;
float maxSpeed, minSpeed;

void setup() {
  cvMax = new ControlP5(this);
  cvMax.addSlider("VelocidadMax")
    .setPosition(10, 40)
    .setRange(6, 32)
    .setValue(15)
    ;
  cvMin = new ControlP5(this);
  cvMin.addSlider("VelocidadMin")
    .setPosition(10, 60)
    .setRange(2, 15)
    .setValue(2)
    ;
     
  // Open the file from the createWriter() example
  reader = createReader("Qdata.txt"); 
  size(600, 600); 
  background(255);
  smooth(8);
  size = 0;
  line = " ";
  for (line = " ";line != null;line=getLine(reader)) size++;
  println("size = " + size);
  reader = createReader("Qdata.txt"); 
  x = new float[size];
  y = new float[size];
  speed = new float[size];
  air = new float[size];
  
  line = " ";
  int pos = 0;
  maxX = -1000000.0;
  minX =  10000000.0;
  maxY = -10000000.0;
  minY =  10000000.0;
  
  for (line=getLine(reader); line != null; line=getLine(reader)) {
    String[] pieces = split(line, ',');
    x[pos] = float(pieces[0]);
    y[pos] = float(pieces[1]);
    speed[pos] =float(pieces[2]);
    air[pos] = float(pieces[3]);
    maxX = max(maxX, x[pos]);
    minX = min(minX, x[pos]);
    maxY = max(maxY, y[pos]);
    minY = min(minY, y[pos]);
    maxAir = max(air[pos],maxAir);
    minAir = min(air[pos],minAir);
    maxSpeed = max(speed[pos],maxSpeed);
    minSpeed = min(speed[pos],minSpeed);
    pos++;
  }
  frameRate(30);
  print("x "+minX+" "+maxX);
  print("y "+minY+" "+maxY);
}

void draw() {
  background(255,255,255);
  strokeWeight(1);
  noStroke();
  fill(0);
 
  for (int i = 0; i < size-1; i++) {
    float xpos = map(x[i],minX,maxX,20,width-20);
    float ypos = map(y[i],minY,maxY,20,height-20);
    float airVal = map(air[i],minAir,maxAir,0,255);
    float speedVal = map(speed[i],minSpeed,maxSpeed,VelocidadMax,VelocidadMin);
    noStroke();
    fill(0,airVal);
    ellipse(xpos,ypos,speedVal,speedVal);
  }
} 

//geographic to cartessian
float toX(float lat, float lon) {
  float x = R * cos(lat) * cos(lon);
  return x;
}

float toY(float lat, float lon) {
  float y = R * cos(lat) * sin(lon);
  return y;
}

//get each file line
String getLine(BufferedReader r){
  String l;
  try {
   l = r.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    l = null;
  } 
  return l;
}