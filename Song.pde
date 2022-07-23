class Song {
  String name;
  float duration;
  boolean isPlaying;
  float timeStamp;
  SoundFile control;
  Instrument[] instrumentalTracks = new Instrument[5];
  
  Song(String n, Instrument[] it, float d, SoundFile c) {
    this.name = n;
    this.isPlaying = false;
    this.duration = d;
    this.timeStamp = 0;
    
    for (int i = 0; i < it.length; i++) 
      this.instrumentalTracks[i] = it[i];
    
    this.control = c;
    this.control.amp(0);  // the control file has the same duration as all instrumental tracks, but it's muted upon object definition so as to not be heard by the user
  }
  
  // Updates the timestamp of the song in every frame by tracking the position of the control file; note that position() is a built-in function
  void updateTimeStamp() {
    this.timeStamp = this.control.position();
    
    if (loop == true) {
      if (this.timeStamp >= this.duration) {
        this.reset();
  
        if (!paused)
          currentSong.playSong();
      }
    }
    
    for (int i = 0; i < instrumentalTracks.length; i++)
      instrumentalTracks[i].timeStamp = this.timeStamp;
  }
  
  // Plays the song from the appropriate timestamp using the control file; note that jump() is a built-in function
  void playSong() {
    this.control.jump(timeStamp);

    for (int i = 0; i < this.instrumentalTracks.length; i++) {
      this.instrumentalTracks[i].timeStamp = this.control.position();  // Each instrumental track's timestamp is kept track of using the control file's position (a built-in function) 
        
      if (this.instrumentalTracks[i].isPlaying == true) 
        this.instrumentalTracks[i].playInstrument();
      
      else
        this.instrumentalTracks[i].pauseInstrument();
    }  
  }
  
  // Pauses the song while retaining the appropriate timestamp using the control file
  void pauseSong() {
      this.control.pause();
    
      for (int i = 0; i < this.instrumentalTracks.length; i++) 
        if (this.instrumentalTracks[i].isPlaying == true)
          this.instrumentalTracks[i].pauseInstrument();  
  }
  
  // Called when manipulating the duration slider, making the song play from the specified timestamp
  void jumpTo(float f) {
    this.control.jump(f);
    
    if (!paused) {
      for (int i = 0; i < this.instrumentalTracks.length; i++) {
        if (instrumentalTracks[i].isPlaying == true)
          this.instrumentalTracks[i].file.jump(f);
      }
    }
    
    else
      this.control.pause();
  }
  
  // resets the timestamp and plays the song from the beginning (given that the program is not paused)
  void reset() {
    this.timeStamp = 0;
    
    for (int i = 0; i < this.instrumentalTracks.length; i++)
      instrumentalTracks[i].timeStamp = this.timeStamp;
      
    durationSlider.setValue(0);
  }
  
  // returns the timestamp specified by the duration slider's position (since the slider has values 0 to 100, not 0 to the song's total duration)
  float getPosition(float f) {
    return this.duration / 100 * f;
  }
}
