//globally declare the min and max variables that you need in parseInfo
float minX, maxX;
float minY, maxY;
int totalCount; // total number of places
float minPopulation, maxPopulation;
float minSurface, maxSurface;
float minAltitude, maxAltitude;
float x[];
float y[];
float population[];
float surface[];
Place places[];
//average population density of France
float minDensity=118.8; 
float maxDensity=118.8; 
float minPopulationToDisplay  = 10000;
String lastCity;
Place selectedCity =null;
Place lastSelectedCity;


void setup() {
  size(800, 800);
  readData();
}


void draw() {
  background(26, 26, 26);
  text("Displaying populations above "+ minPopulationToDisplay, 40, 40);
  for (int i=0; i<totalCount-2; ++i) {
    if (places[i].getPopulation()>=minPopulationToDisplay) { 
      places[i].draw();
      loop();
    }
  }
}

void readData() {
  String[] lines = loadStrings("villes.tsv");
  parseInfo(lines[0]); // read the header line
  places = new Place[totalCount];
  for (int i=2; i<totalCount; i++) {
    places[i-2] = new Place(lines[i]);
  }
}

void keyPressed() {
  if (keyCode ==UP) {
    minPopulationToDisplay = minPopulationToDisplay*10;
  } else if (keyCode ==DOWN) {
    minPopulationToDisplay = minPopulationToDisplay/10;
  }
  redraw();
}

void mouseMoved() {
  //println("x : " + mouseX + ", y : " + mouseY);
  Place city = pick(mouseX, mouseY);
  if (city!=null) {
    //if it's the first time a city is selected
    if (selectedCity == null) {
      selectedCity = city;
      //and the highlight is shown
      selectedCity.toggleHighlight(); 
      selectedCity.draw();
     
    } else if (selectedCity.getName() != city.getName() && lastSelectedCity != null) {
        //the city before loses it's highlight
        lastSelectedCity.toggleHighlight();
        //that city is redrawn
        lastSelectedCity.draw();
        //the new next to last becomes the last city selected
        lastSelectedCity = selectedCity;
        //the currently selected city gets the new city value    
        selectedCity = city;
        //and the highlight is shown
        selectedCity.toggleHighlight(); 
        selectedCity.draw();
        println(selectedCity.getName());
//if it's the 2nd time a city is selected, and the lastSelectedCity has no value
      } else if(lastSelectedCity == null){
         lastSelectedCity = selectedCity;
        //the currently selected city gets the new city value    
        selectedCity = city;
        //and the highlight is shown
        selectedCity.toggleHighlight(); 
        selectedCity.draw();
        println(selectedCity.getName());

      }
  }
}

Place pick(int px, int py) {
  for (int i = totalCount-3; i>=0; i--) {
    if (places[i].contains(px, py)) {
      return places[i];
    }
  }  
  return null;
}

void parseInfo(String line) {
  String infoString = line.substring(2); // remove the #
  String[] infoPieces = split(infoString, ',');
  totalCount = int(infoPieces[0]);
  minX = float(infoPieces[1]);
  maxX = float(infoPieces[2]);
  minY = float(infoPieces[3]);
  maxY = float(infoPieces[4]);
  minPopulation = float(infoPieces[5]);
  maxPopulation = float(infoPieces[6]);
  minSurface = float(infoPieces[7]);
  maxSurface = float(infoPieces[8]);
  minAltitude = float(infoPieces[9]);
  maxAltitude = float(infoPieces[10]);
}