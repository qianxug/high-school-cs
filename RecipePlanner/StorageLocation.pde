class StorageLocation {
  String name;
  int capacity;
  ArrayList<Food> containedFoodItems;
  
  StorageLocation(String n, int c) {
    this.name = n;
    this.capacity = c;
    this.containedFoodItems = new ArrayList<Food>();
  }
  
  void checkStock() {
    if (this.containedFoodItems.size() == 0) {
      println("The", this.name, "is empty.");
    }
    
    else {
      print("Here is what's in the", this.name, "now: ");
      for (int i = 0; i < this.containedFoodItems.size(); i++) {
        print(this.containedFoodItems.get(i).name);
        
        if (i < (this.containedFoodItems.size() - 1))
          print(", ");
      }
      
      println();
    }
    
    println();
  }
}
