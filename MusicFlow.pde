import processing.sound.*;
import g4p_controls.*;

// Setting up global variables
// Images and sound files
SoundFile fileA1, fileA2,  fileA3, fileA4, fileA5, fileACtrl;
SoundFile fileB1, fileB2,  fileB3, fileB4, fileB5, fileBCtrl;
SoundFile fileC1, fileC2,  fileC3, fileC4, fileC5, fileCCtrl;
PImage stage, sign;
PImage imgA1, imgA2, imgA3, imgA4, imgA5;
PImage imgB1, imgB2, imgB3, imgB4, imgB5;
PImage imgC1, imgC2, imgC3, imgC4, imgC5;
PImage note1A, note1B, note2A, note2B, note3A, note3B;

// Instruments and songs
Instrument violinA, violaA, harpA, stringsA, fluteA;
Instrument celloB, violaB, pianoB, percB, contraB;
Instrument bellC, fluteC, pianoC, stringsC, xyloC;
Song songA, songB, songC, currentSong, previousSong;

// Arrays for some G4P components and images, allowing us to optimize certain code blocks below using for loops 
GCheckbox[] instruments = new GCheckbox[5];
GSlider[] volumeSliders = new GSlider[5];
PImage[] notesA = new PImage[3];
PImage[] notesB = new PImage[3];

// Other miscellaneous variables
PFont font;
float masterVolume;
boolean paused = false;
boolean loop = false;
int frames = 0;
int oneFifthSeconds = 0;

public void setup(){
  size(1000, 1000);
  createGUI();
  
  loadData();
  setInitValues();
}

public void draw(){
  background(235);
  frames++;
  // the below variable is used to determine the "sway" speed (rate at which each note bounces from left-tilting to right-tilting and vice versa) of the musical notes in the main window
  oneFifthSeconds = frames / 12;  
    
  determineCurrentSong();
  songChanged();  
  drawThings();    
  currentSong.updateTimeStamp();

  durationSlider.setValue(100 / currentSong.duration * currentSong.timeStamp);  
  previousSong = currentSong;
}

// Loads all necessary assets from the data folder, populates arrays defined at the top, and creates all Instrument and Song objects
void loadData() {
  stage = loadImage("stage.png");
  sign = loadImage("sign.png");
  
  font = loadFont("BodoniMT-Italic-48.vlw");
  
  note1A = loadImage("note1A.png");
  note1B = loadImage("note1B.png");
  note2A = loadImage("note2A.png");
  note2B = loadImage("note2B.png");
  note3A = loadImage("note3A.png");
  note3B = loadImage("note3B.png");
  
  instruments[0] = instrument1;
  instruments[1] = instrument2;
  instruments[2] = instrument3;
  instruments[3] = instrument4;
  instruments[4] = instrument5;
  
  volumeSliders[0] = instrument1Slider;
  volumeSliders[1] = instrument2Slider;
  volumeSliders[2] = instrument3Slider;
  volumeSliders[3] = instrument4Slider;
  volumeSliders[4] = instrument5Slider;
  
  notesA[0] = note1A;
  notesA[1] = note2A;
  notesA[2] = note3A;
  notesB[0] = note1B;
  notesB[1] = note2B;
  notesB[2] = note3B;

  fileA1 = new SoundFile(this, "Violins.wav");
  fileA2 = new SoundFile(this, "Violas.wav");
  fileA3 = new SoundFile(this, "Harpsichord.wav");
  fileA4 = new SoundFile(this, "bStrings.wav");
  fileA5 = new SoundFile(this, "bFlute.wav");
  fileACtrl = new SoundFile(this, "Violins.wav");  // control file for songA
  
  fileB1 = new SoundFile(this, "Cello.wav");
  fileB2 = new SoundFile(this, "Viola2.wav");
  fileB3 = new SoundFile(this, "Piano2.wav");
  fileB4 = new SoundFile(this, "Percussion2.wav");
  fileB5 = new SoundFile(this, "Contrabass2.wav");
  fileBCtrl = new SoundFile(this, "Cello.wav");  // control file for songB
  
  fileC1 = new SoundFile(this, "Bells3.wav");
  fileC2 = new SoundFile(this, "Flute3.wav");
  fileC3 = new SoundFile(this, "Piano3.wav");
  fileC4 = new SoundFile(this, "Strings.wav");
  fileC5 = new SoundFile(this, "Xylophone3.wav");
  fileCCtrl = new SoundFile(this, "Bells3.wav");  // control file for songC

  imgA1 = loadImage("violinPlay.png");
  imgA2 = loadImage("violaPlay.png");
  imgA3 = loadImage("pianoPlay.png");
  imgA4 = loadImage("celloPlay.png");
  imgA5 = loadImage("flutePlay.png");
  
  imgB1 = imgA4;
  imgB2 = imgA2;
  imgB3 = imgA3;
  imgB4 = loadImage("drumPlay.png");
  imgB5 = loadImage("contrabassPlay.png");
  
  imgC1 = loadImage("bellPlay.png");
  imgC2 = imgA5;
  imgC3 = imgA3;
  imgC4 = imgA1;
  imgC5 = loadImage("xylophonePlay.png");

  violinA = new Instrument("Violin", fileA1, imgA1);
  violaA = new Instrument("Viola", fileA2, imgA2);
  harpA = new Instrument("Harpsichord", fileA3, imgA3);
  stringsA = new Instrument("Bass Strings", fileA4, imgA4);
  fluteA = new Instrument("Flute", fileA5, imgA5);
  
  celloB = new Instrument("Cello", fileB1, imgB1);
  violaB = new Instrument("Viola", fileB2, imgB2);
  pianoB = new Instrument("Piano", fileB3, imgB3);
  percB = new Instrument("Drums", fileB4, imgB4);
  contraB = new Instrument("Contrabass", fileB5, imgB5);
  
  bellC = new Instrument("Tubular Bell", fileC1, imgC1);
  fluteC = new Instrument("Flute", fileC2, imgC2);
  pianoC = new Instrument("Piano", fileC3, imgC3);
  stringsC = new Instrument("Strings", fileC4, imgC4);
  xyloC = new Instrument("Xylophone", fileC5, imgC5);

  Instrument[] instrumentalTracksA = {violinA, violaA, harpA, stringsA, fluteA};
  Instrument[] instrumentalTracksB = {celloB, violaB, pianoB, percB, contraB};
  Instrument[] instrumentalTracksC = {bellC, fluteC, pianoC, stringsC, xyloC};

  songA = new Song("Canon in D", instrumentalTracksA, 196, fileACtrl);  
  songB = new Song("River Flows in You", instrumentalTracksB, 191, fileBCtrl);
  songC = new Song("Carol of the Bells", instrumentalTracksC, 121, fileCCtrl);
}

// Determines the song that is chosen to be played in the current frame, as all related functions are called on the currentSong variable   
void determineCurrentSong() {
  if (songA.isPlaying)
    currentSong = songA;
    
  else if (songB.isPlaying)
    currentSong = songB;

  else if (songC.isPlaying)
    currentSong = songC;
}

// Details a series of actions that need to be completed if the song chosen to be played in the current frame is different from the previous
void songChanged() {
  if (currentSong != previousSong) {
    try {
      previousSong.reset();
    }
    
    catch (Exception e) {}
    
    // Assigns the names of the five instruments involved in the new song to the instrument checkboxes on the GUI 
    for (int i = 0; i < instruments.length; i++) {
      instruments[i].setText(currentSong.instrumentalTracks[i].name);
      currentSong.instrumentalTracks[i].volume = volumeSliders[i].getValueF();
      
      // Retains the checkbox states (i.e. if the first instrument is checked for the previous song and the user switches to the new song, the instrument of the new song that is controlled by the checkbox will play)
      if (instruments[i].isSelected() == true) 
        currentSong.instrumentalTracks[i].isPlaying = true;
      
      else
        currentSong.instrumentalTracks[i].isPlaying = false;
    }
    
    // Resets the song's duration progression on the duration slider
    durationSlider.setValue(0);
    
    // Sets the duration slider's ending value to the current song's total duration
    if (currentSong == songA)
      durationEnd.setText("3:16");
    
    else if (currentSong == songB)
      durationEnd.setText("3:11");
    
    else if (currentSong == songC)
      durationEnd.setText("2:01");
    
    try {
      previousSong.pauseSong();
    }
    
    catch (Exception e) {}
    
    if (!paused)
      currentSong.playSong();    
  }
}

// Sets it up so that the program plays the first song, Canon in D, upon initiation
void setInitValues() {
  masterVolume = 20;
  currentSong = songA;
  songA.isPlaying = true;
  durationStart.setText("0:00");
  durationEnd.setText("3:16");
  
  currentSong.playSong();
}

// Draws everything on the main window
void drawThings() {
  
  // Background stuff
  image(stage, 0, 0, 1000, 1000);
  image(sign, 200, 100, 600, 200);
  
  // Displays the song that is currently playing
  fill(0);
  textFont(font);
  textAlign(CENTER);
  text("Currently playing:", 500, 185);
  text(currentSong.name, 500, 235);

  int x = 0;
  int y = 450;
  
  // Draws images of each musician according to the current song's instrument choices 
  for (int i = 0; i < currentSong.instrumentalTracks.length; i++) {
    image(currentSong.instrumentalTracks[i].image, x, y, 200, 450);
    int a = x + 75;
    int b = y;
    
    // Bounces musical notes on instruments that are selected, given that the program is not paused, the master volume isn't set to 0, and the instrument's volume isn't set to 0
    if (!paused && instruments[i].isSelected() && masterVolume != 0 && currentSong.instrumentalTracks[i].volume != 0) {
      if (oneFifthSeconds % 2 == 0) {
        for (int j = 0; j < 3; j++) {
            image(notesA[j], a, b, 50, 50);
            a += 40;
            b -= 20;
        }
      }
      
      else {
        for (int j = 0; j < 3; j++) {
            image(notesB[j], a, b, 50, 50);
            a += 40;
            b -= 20;
      }
    }
    }
    x += 200;
  }
}
