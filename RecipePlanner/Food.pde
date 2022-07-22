class Food {
  String name;
  int expiry;
  IntList purchaseDays;
  StorageLocation locationStored;
  boolean isOwned;
  
  Food(String n, int e, StorageLocation ls) {
    this.name = n;
    this.expiry = e;
    this.locationStored = ls;
    this.isOwned = false;
    this.purchaseDays = new IntList();
  }
  
  void isThrownOut() {
    if (this.isOwned == false) {
      println("You cannot throw out", this.name, "when you don't own it in the first place.");
    }
    
    else {
      println("One serving of", this.name, "has been thrown out.");
      
      int i = getIndex(this);
      this.locationStored.containedFoodItems.remove(i);
      this.purchaseDays.remove(0);
      
      if (this.purchaseDays.size() == 0) {
        this.isOwned = false;
      }
    }
    
    println();
  }
  
  void checkExpiry(int currentDay) {
    if (isExpiredInternal(currentDay) == 0)
      println("You cannot check the expiry date of", this.name, "when you don't own it in the first place.");
    
    else if (isExpiredInternal(currentDay) == -1)
      println("All of the", this.name, "that you own has gone bad! Make sure to throw it out and be more mindful of expiry dates next time.");
    
    else {
      boolean[] isEachServingExpired = checkExpiryInternal(currentDay);
      int expiryCount = 0;
      
      for (int i = 0; i < isEachServingExpired.length; i++) {
        if (isEachServingExpired[i] == true)
          expiryCount++;          
      }
      
      if (expiryCount == 0)
        println("None of the", this.name, "that you own is expired.");
      
      else
        if (expiryCount == 1)
          println(expiryCount + "/" + isEachServingExpired.length, "of the servings of", this.name, "that you own has gone bad! Make sure to throw out that serving and be more mindful of expiry dates next time.");
        
        else
          println(expiryCount + "/" + isEachServingExpired.length, "of the servings of", this.name, "that you own have gone bad! Make sure to throw out those servings and be more mindful of expiry dates next time.");
    }
    
    println();
  }
  
  int isExpiredInternal(int currentDay) {
    int isExpired;
    
    if (this.isOwned == false) {
      isExpired = 0;
    }
    
    else {
      int[] daysUntilExpiry = calculateDaysUntilExpiry(currentDay);
      int i = 0;
      isExpired = -1; 
      
      while (isExpired == -1 && i < daysUntilExpiry.length)
        if (daysUntilExpiry[i] >= 0)
          isExpired = 1;
        
        else
          i++;
    }
      
    return isExpired;
  }
  
  boolean[] checkExpiryInternal(int currentDay) {
    int[] daysUntilExpiry = calculateDaysUntilExpiry(currentDay);
    boolean[] isEachServingExpired = new boolean[this.purchaseDays.size()];
    
    for (int i = 0; i < daysUntilExpiry.length; i++) {
      if (daysUntilExpiry[i] >= 0)
        isEachServingExpired[i] = false;
        
      else
        isEachServingExpired[i] = true;
    }
    
    return isEachServingExpired;
  }
  
  private int[] calculateDaysUntilExpiry(int currentDay) {
    int[] daysUntilExpiry = new int[this.purchaseDays.size()];
    
    for (int i = 0; i < daysUntilExpiry.length; i++) {
      daysUntilExpiry[i] = this.expiry - (currentDay - this.purchaseDays.get(i));
    }
    
    return daysUntilExpiry;
  }
  
  int getIndex(Food f) {
    boolean itemFound = false;
    int i = 0;
    
    while (itemFound == false) {
      if (f != this.locationStored.containedFoodItems.get(i)) {
        i++;
      }
      
      else
        itemFound = true;
    }
    
    return i;
  }
}
