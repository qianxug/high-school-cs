/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:856549:
  appc.background(230);
} //_CODE_:window1:856549:

public void pauseButtonPressed(GButton source, GEvent event) { //_CODE_:pause:257085:
  paused = !paused;

  if (paused == false) {
    currentSong.playSong();
    pause.setText("Pause");
  }
    
  else {
    try {
    currentSong.pauseSong();
    }
    
    catch (Exception e) {}
    
    pause.setText("Play");
  }
} //_CODE_:pause:257085:

public void restartButtonPressed(GButton source, GEvent event) { //_CODE_:restart:920735:
  currentSong.reset();
  currentSong.control.jump(0);
  currentSong.control.pause();
  
  if (!paused)
    currentSong.playSong();
} //_CODE_:restart:920735:

public void songAButtonPressed(GButton source, GEvent event) { //_CODE_:songAButton:592213:
  songA.isPlaying = true;
  songB.isPlaying = false;
  songC.isPlaying = false;
} //_CODE_:songAButton:592213:

public void songBButtonPressed(GButton source, GEvent event) { //_CODE_:songBButton:673190:
  songA.isPlaying = false;
  songB.isPlaying = true;
  songC.isPlaying = false;
} //_CODE_:songBButton:673190:

public void songCButtonPressed(GButton source, GEvent event) { //_CODE_:songCButton:409931:
  songA.isPlaying = false;
  songB.isPlaying = false;
  songC.isPlaying = true;
} //_CODE_:songCButton:409931:

public void durationSliderDragged(GSlider source, GEvent event) { //_CODE_:durationSlider:446767:
  float f = currentSong.getPosition(durationSlider.getValueF());

  if (durationSlider.isDragging()) {
    noLoop();  // if the user is dragging the duration slider, then stop the draw() function from running so that it doesn't overwrite the user's actions
    currentSong.timeStamp = f;
    
    // if the song is on loop and the slider has been dragged to the very end (beyond the current song's duration), then set it back to zero 
    if (loop == true) {
      if (currentSong.timeStamp >= currentSong.duration) {
        currentSong.timeStamp = 0;
        currentSong.reset();
      }
    }
            
    currentSong.jumpTo(currentSong.timeStamp);
  }
  
  // once the user is no longer manipulating the duration slider, resume running the draw() function
  else 
    loop(); 
} //_CODE_:durationSlider:446767:

public void instrument1SliderDragged(GSlider source, GEvent event) { //_CODE_:instrument1Slider:912754:
  currentSong.instrumentalTracks[0].volume = instrument1Slider.getValueF();

  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument1Slider:912754:

public void volumeInputted(GTextField source, GEvent event) { //_CODE_:volumeInput:961451:
  try {
    masterVolume = float(volumeInput.getText());
    
    if (masterVolume < 0)
      masterVolume = 0;
    
    else if (masterVolume > 100)
      masterVolume = 100;
  }
  
  catch (Exception e) {
    masterVolume = 50;
  }
  
  if (!paused)
    currentSong.playSong();
} //_CODE_:volumeInput:961451:

public void instrument1Checked(GCheckbox source, GEvent event) { //_CODE_:instrument1:280366:
  if (instrument1.isSelected() == true)
    currentSong.instrumentalTracks[0].isPlaying = true;
  
  else
    currentSong.instrumentalTracks[0].isPlaying = false;
  
  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument1:280366:

public void instrument2Checked(GCheckbox source, GEvent event) { //_CODE_:instrument2:507594:
  if (instrument2.isSelected() == true)
    currentSong.instrumentalTracks[1].isPlaying = true;
  
  else
    currentSong.instrumentalTracks[1].isPlaying = false;
    
  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument2:507594:

public void instrument2SliderDragged(GSlider source, GEvent event) { //_CODE_:instrument2Slider:818735:
  currentSong.instrumentalTracks[1].volume = instrument2Slider.getValueF();

  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument2Slider:818735:

public void instrument3SliderDragged(GSlider source, GEvent event) { //_CODE_:instrument3Slider:726747:
  currentSong.instrumentalTracks[2].volume = instrument3Slider.getValueF();

  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument3Slider:726747:

public void Instrument4SliderDragged(GSlider source, GEvent event) { //_CODE_:instrument4Slider:967662:
  currentSong.instrumentalTracks[3].volume = instrument4Slider.getValueF();

  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument4Slider:967662:

public void Instrument5SliderDragged(GSlider source, GEvent event) { //_CODE_:instrument5Slider:710306:
  currentSong.instrumentalTracks[4].volume = instrument5Slider.getValueF();

  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument5Slider:710306:

public void instrument3Checked(GCheckbox source, GEvent event) { //_CODE_:instrument3:716764:
  if (instrument3.isSelected() == true)
    currentSong.instrumentalTracks[2].isPlaying = true;
  
  else
    currentSong.instrumentalTracks[2].isPlaying = false;
  
  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument3:716764:

public void instrument4Checked(GCheckbox source, GEvent event) { //_CODE_:instrument4:967866:
  if (instrument4.isSelected() == true)
    currentSong.instrumentalTracks[3].isPlaying = true;
  
  else
    currentSong.instrumentalTracks[3].isPlaying = false;  
  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument4:967866:

public void instrument5Checked(GCheckbox source, GEvent event) { //_CODE_:instrument5:203222:
  if (instrument5.isSelected() == true)
    currentSong.instrumentalTracks[4].isPlaying = true;
  
  else
    currentSong.instrumentalTracks[4].isPlaying = false;
    
  if (!paused)
    currentSong.playSong();
} //_CODE_:instrument5:203222:

public void loopChecked(GCheckbox source, GEvent event) { //_CODE_:loopCheckbox:575514:
  if (loopCheckbox.isSelected() == true)
    loop = true;
  
  else
    loop = false;
} //_CODE_:loopCheckbox:575514:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 700, 620, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  lengthLabel = new GLabel(window1, 205, 30, 80, 20);
  lengthLabel.setText("Duration");
  lengthLabel.setLocalColorScheme(GCScheme.RED_SCHEME);
  lengthLabel.setOpaque(false);
  pause = new GButton(window1, 25, 30, 80, 30);
  pause.setText("Pause");
  pause.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  pause.addEventHandler(this, "pauseButtonPressed");
  restart = new GButton(window1, 25, 80, 80, 30);
  restart.setText("Restart");
  restart.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  restart.addEventHandler(this, "restartButtonPressed");
  songAButton = new GButton(window1, 25, 320, 150, 30);
  songAButton.setText("Canon in D");
  songAButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  songAButton.addEventHandler(this, "songAButtonPressed");
  songBButton = new GButton(window1, 25, 380, 150, 30);
  songBButton.setText("River Flows in You");
  songBButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  songBButton.addEventHandler(this, "songBButtonPressed");
  songCButton = new GButton(window1, 25, 440, 150, 30);
  songCButton.setText("Carol of the Bells");
  songCButton.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  songCButton.addEventHandler(this, "songCButtonPressed");
  togGroup1 = new GToggleGroup();
  togGroup2 = new GToggleGroup();
  durationSlider = new GSlider(window1, 235, 55, 350, 50, 10.0);
  durationSlider.setLimits(0.0, 0.0, 100.0);
  durationSlider.setShowTicks(true);
  durationSlider.setNumberFormat(G4P.DECIMAL, 0);
  durationSlider.setLocalColorScheme(GCScheme.RED_SCHEME);
  durationSlider.setOpaque(false);
  durationSlider.addEventHandler(this, "durationSliderDragged");
  instrument1Slider = new GSlider(window1, 400, 180, 240, 60, 10.0);
  instrument1Slider.setLimits(0.005, 0.0, 0.01);
  instrument1Slider.setNumberFormat(G4P.DECIMAL, 2);
  instrument1Slider.setOpaque(false);
  instrument1Slider.addEventHandler(this, "instrument1SliderDragged");
  volumeInput = new GTextField(window1, 25, 170, 100, 30, G4P.SCROLLBARS_NONE);
  volumeInput.setText("20");
  volumeInput.setPromptText("0 - 100");
  volumeInput.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  volumeInput.setOpaque(true);
  volumeInput.addEventHandler(this, "volumeInputted");
  instrument1 = new GCheckbox(window1, 260, 200, 120, 20);
  instrument1.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  instrument1.setText("Instrument #1");
  instrument1.setOpaque(false);
  instrument1.addEventHandler(this, "instrument1Checked");
  volumeLabel = new GLabel(window1, 25, 150, 120, 20);
  volumeLabel.setTextAlign(GAlign.LEFT, GAlign.CENTER);
  volumeLabel.setText("Master Volume");
  volumeLabel.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  volumeLabel.setOpaque(false);
  instrument2 = new GCheckbox(window1, 260, 280, 120, 20);
  instrument2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  instrument2.setText("Instrument #2");
  instrument2.setOpaque(false);
  instrument2.addEventHandler(this, "instrument2Checked");
  instrument2Slider = new GSlider(window1, 400, 260, 240, 60, 10.0);
  instrument2Slider.setLimits(0.005, 0.0, 0.01);
  instrument2Slider.setNumberFormat(G4P.DECIMAL, 2);
  instrument2Slider.setOpaque(false);
  instrument2Slider.addEventHandler(this, "instrument2SliderDragged");
  instrument3Slider = new GSlider(window1, 400, 340, 240, 60, 10.0);
  instrument3Slider.setLimits(0.005, 0.0, 0.01);
  instrument3Slider.setNumberFormat(G4P.DECIMAL, 2);
  instrument3Slider.setOpaque(false);
  instrument3Slider.addEventHandler(this, "instrument3SliderDragged");
  instrument4Slider = new GSlider(window1, 400, 420, 240, 60, 10.0);
  instrument4Slider.setLimits(0.005, 0.0, 0.01);
  instrument4Slider.setNumberFormat(G4P.DECIMAL, 2);
  instrument4Slider.setOpaque(false);
  instrument4Slider.addEventHandler(this, "Instrument4SliderDragged");
  instrument5Slider = new GSlider(window1, 400, 500, 240, 60, 10.0);
  instrument5Slider.setLimits(0.005, 0.0, 0.01);
  instrument5Slider.setNumberFormat(G4P.DECIMAL, 2);
  instrument5Slider.setOpaque(false);
  instrument5Slider.addEventHandler(this, "Instrument5SliderDragged");
  instrument3 = new GCheckbox(window1, 260, 360, 120, 20);
  instrument3.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  instrument3.setText("Instrument #3");
  instrument3.setOpaque(false);
  instrument3.addEventHandler(this, "instrument3Checked");
  instrument3.setSelected(true);
  instrument4 = new GCheckbox(window1, 260, 440, 120, 20);
  instrument4.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  instrument4.setText("Instrument #4");
  instrument4.setOpaque(false);
  instrument4.addEventHandler(this, "instrument4Checked");
  instrument5 = new GCheckbox(window1, 260, 520, 120, 20);
  instrument5.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  instrument5.setText("Instrument #5");
  instrument5.setOpaque(false);
  instrument5.addEventHandler(this, "instrument5Checked");
  loopCheckbox = new GCheckbox(window1, 25, 225, 130, 20);
  loopCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  loopCheckbox.setText("Loop");
  loopCheckbox.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  loopCheckbox.setOpaque(false);
  loopCheckbox.addEventHandler(this, "loopChecked");
  durationStart = new GLabel(window1, 150, 70, 80, 20);
  durationStart.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  durationStart.setText("start");
  durationStart.setLocalColorScheme(GCScheme.RED_SCHEME);
  durationStart.setOpaque(false);
  durationEnd = new GLabel(window1, 590, 70, 80, 20);
  durationEnd.setText("end");
  durationEnd.setLocalColorScheme(GCScheme.RED_SCHEME);
  durationEnd.setOpaque(false);
  label1 = new GLabel(window1, 25, 280, 140, 20);
  label1.setText("Choose a song:");
  label1.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label1.setOpaque(false);
  instrumentVolumeLabel = new GLabel(window1, 400, 145, 200, 20);
  instrumentVolumeLabel.setText("Adjust each instrument's volume:");
  instrumentVolumeLabel.setOpaque(false);
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GLabel lengthLabel; 
GButton pause; 
GButton restart; 
GButton songAButton; 
GButton songBButton; 
GButton songCButton; 
GToggleGroup togGroup1; 
GToggleGroup togGroup2; 
GSlider durationSlider; 
GSlider instrument1Slider; 
GTextField volumeInput; 
GCheckbox instrument1; 
GLabel volumeLabel; 
GCheckbox instrument2; 
GSlider instrument2Slider; 
GSlider instrument3Slider; 
GSlider instrument4Slider; 
GSlider instrument5Slider; 
GCheckbox instrument3; 
GCheckbox instrument4; 
GCheckbox instrument5; 
GCheckbox loopCheckbox; 
GLabel durationStart; 
GLabel durationEnd; 
GLabel label1; 
GLabel instrumentVolumeLabel; 
