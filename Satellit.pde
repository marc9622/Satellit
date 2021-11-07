// 3D Earthquake Data Visualization
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/058-earthquakeviz3d.html
// https://youtu.be/dbs4IYGfAXc
// https://editor.p5js.org/codingtrain/sketches/tttPKxZi

float angle;

Table table;
float r = 200;

PImage earth;
PShape globe;

PVector yAxis = new PVector(0, 1, 0);
PVector zAxis = new PVector(0, 0, 1);

float rotation = 0;

float satLon, satLat, satAlt;
float movLon, movLat;

void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");

  JSONObject j =
    loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=T85ZMQ-LFT6CU-67TTFZ-4SR8");
  JSONArray positionsJson = j.getJSONArray("positions");
   
  JSONObject pos1 = positionsJson.getJSONObject(0);
  JSONObject pos2 = positionsJson.getJSONObject(1);
  
  satLon = pos1.getFloat("satlongitude");
  satLat = pos1.getFloat("satlatitude");
  //sat1Alt = pos1.getFloat("satAltitude");
  
  movLon = pos2.getFloat("satlongitude") - satLon;
  movLat = pos2.getFloat("satlatitude") - satLat;
  //sat2Alt = pos1.getFloat("satAltitude");

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  
}

void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  
  lights();
  fill(200);
  noStroke();
  sphere(r);
  //shape(globe);

  float speed = frameCount * 10;

  float theta = radians(satLat);
  float phi = radians(satLon) + PI;

  float x =  (r + 50) * cos(theta) * cos(phi);
  float y = -(r + 50) * sin(theta);
  float z = -(r + 50) * cos(theta) * sin(phi);

  PVector pos = new PVector(x, y, z);

  PVector xaxis = new PVector(1, 0, 0);
  float angleb = PVector.angleBetween(xaxis, pos) * speed;
  PVector raxis = xaxis.cross(pos);

  push();
  translate(x, y, z);
  rotate(angleb, raxis.x, raxis.y, raxis.z);
  fill(255);
  box(5);
  pop(); 
}

void keyPressed() {
  
  if(key == LEFT)
    angle -= 0.01;
  if(key == RIGHT)
    angle += 0.01;
  
}
