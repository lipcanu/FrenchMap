int three=0;
int two=0;
class Place {
  int postalcode;
  String name;
  float x; 
  float y; 
  float population;
  float surface;
  float density; 
  color densityColor;
  int radius;
  boolean highlighted = false;


  Place(String line) {
    String pieces[] = split(line, TAB);
    postalcode = int(pieces[0]);
    x = float(pieces[1]);
    y = float(pieces[2]);
    name = pieces[4];
    population = float(pieces[5]);
    surface = float(pieces[6]);
    if (surface>0) { //if the surface is 0, then the density becomes infinite, which would be false
      density = population/surface;
      if (density > maxDensity) {
        maxDensity = density;
      } else if (density < minDensity) {
        minDensity = density;
      }
    } else {
      density = 1.0; // arbitrary choice due to data where a city can have no surface
    }

    radius = (int) mapPopulation(population);
    int densityIndicator  = mapDensity(density);
    mapDensityToColor(densityIndicator);
  }

  void draw() {    
    //draw an ellipse with the radius relative to the population of the city
    noStroke();
    fill(densityColor, 200);   
    ellipse((int)mapX(x), (int)mapY(y), radius, radius);

    if (highlighted) {
      stroke(densityColor);
      noFill();
      ellipse((int)mapX(x), (int)mapY(y), radius*1.5, radius*1.5);
      noStroke();
      fill(0, 200);
      rect((int)mapX(x)+radius*1.5+2, (int)mapY(y)-15, textWidth(name)+4, 20);
      fill(densityColor);
      text(name, (int)mapX(x)+radius*1.5+5, (int)mapY(y) );
    }
  }

  //mapping the position

  float mapX(float x) {
    return map(x, minX, maxX, 0, 800);
  }

  float mapY(float y) {
    return map(y, minY, maxY, 800, 0);
  }

  float mapPopulation(float population) {
    return  map(population, minPopulation, maxPopulation, 2, 70);
  }

  //mapping density
  int mapDensity(float density) {
    float number =  map(density, minDensity, maxDensity, 1.0, 9.0);
    return Math.round(number);
  }

  float getPopulation() {
    return population;
  }

  String getName() {
    return name;
  }
  
  void toggleHighlight(){
    if(highlighted){
      highlighted = false;
    } else {
      highlighted = true;
    }
  }

  boolean contains(int px, int py) {
    // Since we draw a circle, we use here the distance between (px, py) and the circle's center.
    // We add an extra pixel to facilitate mouse picking.
    //from http://www.aviz.fr/wiki/pmwiki.php/Teaching2015/Assignment2
    return dist(mapX(x), mapY(y), px, py) <= (radius + 1);
  }

  void mapDensityToColor(int densityIndicator) {
    switch(densityIndicator) {
    case 1: 
      densityColor =  color(255, 247, 251);
      break;
    case 2: 
      densityColor = color(236, 226, 240);
      break;
    case 3: 
      densityColor =  color(208, 209, 230);
      break;
    case 4: 
      densityColor =  color(166, 189, 219);
      break;
    case 5: 
      densityColor =  color(103, 169, 207);
      break;
    case 6: 
      densityColor =  color(54, 144, 192);
      break;
    case 7: 
      densityColor = color(2, 129, 138);
      break;
    case 8: 
      densityColor =  color(1, 108, 89);
      break;
    case 9: 
      densityColor =  color(1, 70, 54);
      break;
    default: 
      densityColor =  color(128, 0, 38);
      break;
    }
  }
}