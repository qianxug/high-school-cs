class Instrument {
  String name;
  boolean isPlaying;
  float timeStamp;
  SoundFile file;
  float volume;
  PImage image;
  
  Instrument(String n, SoundFile f, PImage i) {
    this.name = n;
    this.isPlaying = false;
    this.timeStamp = 0;
    this.volume = 0.005;
    this.file = f;
    this.image = i;
  }
  
  // Plays the instrumental track from the appropriate timestamp and at a volume that is calculated using both the master volume and the instrument's volume
  void playInstrument() {
    float volumeToPlay = masterVolume * this.volume;
    this.file.amp(volumeToPlay);
    this.file.jump(timeStamp);
  }
  
  void pauseInstrument() {
    this.file.pause();
  }
}
