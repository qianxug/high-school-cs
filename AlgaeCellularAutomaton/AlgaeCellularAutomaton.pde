import g4p_controls.*;

// Modify the value of these variables
String mode = "year-based"; // "custom" or "year-based"
int temperature = 28;    // optimal: 28 degrees celcius; only change the value of this if you chose "custom" above
int sunlightLevel = 5;    // a number between 1 and 5, with 1 being little sunlight and 5 being plenty of sunlight; only change the value of this if you chose "custom" above
float sporeScatteringProbability = 0.00001;    // recommended: 0.00001 for grid size of 22500
int frames = 100;    // speed of animation
float gridSize = 22500;    // this number must be a perfect square; recommended: 22500 (if your computer can handle it)

// DO NOT modify the value of these variables
int padding = 20;
int sideLength = int(sqrt(gridSize));
int[][] cellsNow = new int[sideLength][sideLength];
int[][] cellsNext = new int[sideLength][sideLength];
int[][] yearTemperatures = new int[12][30];
int[] yearSunlightLevels = {1, 2, 3, 3, 4, 5, 5, 4, 3, 2, 1, 1};
float cellSize;
float growthProbability, deathProbability, reproductionAdjustmentFactor;
float freezingProbability, meltingProbability;
int currentMonth, currentDay, frameNumber;
int temperatureToUse, sunlightLevelToUse;
boolean allFrozen, running;

color ice = color(255);
color water = color(176, 248, 255);
color spore = color(255, 255, 122);
color stage1 = color(51, 255, 51);
color stage2 = color(0, 204, 0);
color stage3 = color(0, 153, 0);
color stage4 = color(0, 102, 0);

void setup() {
  size(1000, 800);
  frameRate(frames);
  noStroke();
  createGUI();
  
  running = true; 
  cellSize = (height - 2 * padding) / sideLength;

  initiate();
}

void draw(){
  allFrozen = true;
  background(0);
  
  for (int i = 0; i < sideLength; i++) {
    for (int j = 0; j < sideLength; j++) {
      if (cellsNow[i][j] == 0)
        allFrozen = false;
    }
  }  
  
  if (mode == "year-based") {
    determineProbabilities();
    temperatureToUse = yearTemperatures[currentMonth][currentDay];
    sunlightLevelToUse = yearSunlightLevels[currentMonth];
  }

  scatterSpores();
  growAlgae();
  reproduceAlgae();
  killAlgae();
  freezeWater();
  meltIce();
  drawCells();

  for (int i = 0; i < sideLength; i++) {
    for (int j = 0; j < sideLength; j++) {
      if (cellsNext[i][j] == 0)
        allFrozen = false;
        
      cellsNow[i][j] = cellsNext[i][j];
    }
  }
  displayValues();
  
  if (mode == "year-based") {
    incrementDate();
  }
}

void initializeCells() {
  for (int i = 0; i < sideLength; i++) {
    for (int j = 0; j < sideLength; j++) {
      if (temperatureToUse >= 0) {
        cellsNow[i][j] = 0;
        cellsNext[i][j] = 0;
      }
      
      else {
        cellsNow[i][j] = -1;
        cellsNext[i][j] = -1; 
      }
    }
  }
}

void drawCells() {
  for (int i = 0; i < sideLength; i++) {
    float y = padding + i * cellSize;
    
    for (int j = 0; j < sideLength; j++) {
      float x = padding + j * cellSize;

      if (cellsNow[i][j] == -1) {
          fill(ice);
      }

      else if (cellsNow[i][j] == 0) {
        fill(water);
      }
      
      else if (cellsNow[i][j] == 1) {
        fill(spore);
      }
      
      else if (cellsNow[i][j] == 2) {
        fill(stage1);
      }
      
      else if (cellsNow[i][j] == 3) {
        fill(stage2);
      }
      
      else if (cellsNow[i][j] == 4) {
        fill(stage3);
      }
      
      else if (cellsNow[i][j] == 5) {
        fill(stage4);
      }
      
      square(x, y, cellSize);
    }
  }
}

void generateTemperatures() {
  for (int i = 0; i < 30; i++) {
    yearTemperatures[0][i] = int(random(-13, -4));
    yearTemperatures[1][i] = int(random(-13, -3));
    yearTemperatures[2][i] = int(random(-6, 4));
    yearTemperatures[3][i] = int(random(1, 12));
    yearTemperatures[4][i] = int(random(9, 20));
    yearTemperatures[5][i] = int(random(13, 25));
    yearTemperatures[6][i] = int(random(16, 29));
    yearTemperatures[7][i] = int(random(15, 27));
    yearTemperatures[8][i] = int(random(11, -23));
    yearTemperatures[9][i] = int(random(5, 15));
    yearTemperatures[10][i] = int(random(-2, 7));
    yearTemperatures[11][i] = int(random(-8, 0));
  }
}

void displayValues() {
  fill(255);
  textSize(20);
  
  if (mode == "year-based") {
    text("Month:", 800, 100);
    text(currentMonth+1, 875, 100);
    text("Day:", 800, 200);
    text(currentDay+1, 849, 200);
    text("Temperature:", 800, 300);
    text(yearTemperatures[currentMonth][currentDay], 940, 300);
    text("Sunlight Level:", 800, 400);
    text(yearSunlightLevels[currentMonth], 947, 400);
  }
  
  else {
    text("Temperature:", 800, 100);
    text(temperature, 940, 100);
    text("Sunlight Level:", 800, 200);
    text(sunlightLevel, 948, 200);
  }
}



void determineProbabilities() {
  growthProbability = 0.11 * (sunlightLevelToUse / (abs(27.5 - temperatureToUse) + 1));
  deathProbability = 0.025 * (0.56 - growthProbability);
  reproductionAdjustmentFactor = growthProbability * 8;  
}

void scatterSpores() {
  for (int i = 0; i < sideLength; i++) {
    for (int j = 0; j < sideLength; j++) {
      int x = int(random(0, 1/sporeScatteringProbability));
      if (x == 0 && cellsNow[i][j] == 0)
        cellsNext[i][j] = 1;
    }
  }
}

void growAlgae() {
  for (int i = 0; i < sideLength; i++) {
    for (int j = 0; j < sideLength; j++) {
      int x = int(random(0, 1/growthProbability));
      
      if (x == 0 && cellsNow[i][j] > 0 && cellsNow[i][j] < 5) {
        cellsNext[i][j] = cellsNow[i][j] + 1;
      }
    }
  }
}

void reproduceAlgae() {  
  for (int i = 0; i < sideLength; i++) {
    for (int j = 0; j < sideLength; j++) {
      int reproductionProbability = 0;

      if (cellsNow[i][j] == 0) {
        for (int k = -1; k < 2; k++) {
          for (int l = -1; l < 2; l++) {
            try {
              if (cellsNow[i+k][j+l] == 5) {
              reproductionProbability++;
              }
            }
            catch (Exception notFullySurrounded) {}
          }
        }
        
        float x = random(0, 10);
        if (x < (reproductionProbability * reproductionAdjustmentFactor))
          cellsNext[i][j] = 2;
      }
    }
  }
}

void killAlgae() {
  for (int i = 0; i < sideLength; i++) {
    for (int j = 0; j < sideLength; j++) {
          int x = int(random(0, 1/deathProbability));
          
          if (cellsNow[i][j] > 1 && x == 0)
            cellsNext[i][j] = 0;
    }
  }
}

void incrementDate() {
  frameNumber++;
  
  if (frameNumber == 7) {
    if (currentDay == 29) {
      if (currentMonth == 11)
        currentMonth = 0;
      
      else
        currentMonth++;
        
      currentDay = 0;
    }
    
    else
      currentDay++;
    
    frameNumber = 0;
  }
}

void freezeWater() {
  if (temperatureToUse < 0) {
    int numberOfIceNeighbours = 0;

    for (int i = 0; i < sideLength; i++) {
      for (int j = 0; j < sideLength; j++) {
        freezingProbability = 2 * log(-1 * temperatureToUse);
        numberOfIceNeighbours = 0;
        
        if (cellsNow[i][j] > -1) {
          for (int k = -1; k < 2; k++) {
            for (int l = -1; l < 2; l++) {
              try {
                if (cellsNow[i+k][j+l] == -1)
                  numberOfIceNeighbours++;
              }
              catch (Exception notFullySurrounded) {}  
            }
          } 
          freezingProbability *= pow(numberOfIceNeighbours, 3)/150;
          freezingProbability += 10;

          int x = int(random(0, 1/freezingProbability * 500));
          
          if (x == 0) {
            cellsNext[i][j] = -1;            
          }
        }
      }
    }
  }
}

void meltIce() {
  if (temperatureToUse >= 0) {
    int numberOfWaterNeighbours = 0;

    for (int i = 0; i < sideLength; i++) {
      for (int j = 0; j < sideLength; j++) {
        meltingProbability = log(temperatureToUse + 0.01);
        numberOfWaterNeighbours = 0;

        if (cellsNow[i][j] == -1) {
          for (int k = -1; k < 2; k++) {
            for (int l = -1; l < 2; l++) {
              try {
                if (cellsNow[i+k][j+l] > -1)
                  numberOfWaterNeighbours++;
              }
              catch (Exception notFullySurrounded) {}
            }
          }

          meltingProbability *= pow(numberOfWaterNeighbours, 4)/150;
          meltingProbability += 10;

          int x = int(random(0, 1/meltingProbability * 1500));

          if (x == 0) {
            if (allFrozen) {
              for (int p = 0; p < sideLength; p++) {
                for (int q = 0; q < sideLength; q++) {
                  if (p == 0 || q == 0 || p == sideLength - 1 || q == sideLength - 1) {
                    cellsNext[p][q] = 0;
                  }
                }
              }
              allFrozen = false;
            }
            
            else {
              cellsNext[i][j] = 0;
            }
          }
        }
      }
    }
  }
}

void initiate() {

  if (mode == "year-based") {
    currentMonth = 0;
    currentDay = 0;
    frameNumber = 0;
    generateTemperatures();
    temperatureToUse = yearTemperatures[currentMonth][currentDay];
    sunlightLevelToUse = yearSunlightLevels[currentMonth];
    allFrozen = true;
  }
  
  else {
    temperatureToUse = temperature;
    sunlightLevelToUse = sunlightLevel;
    determineProbabilities();
  }
 
  initializeCells();
}
