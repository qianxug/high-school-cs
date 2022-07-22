class Cook {
  String name, tagline;
  int cookingAbility;
  
  Cook(String n, String t, int ca) {
    this.name = n;
    this.tagline = t;
    this.cookingAbility = ca;
  }
  
  void introduce() {
    println(this.name + ", the", this.tagline + ", who has a cooking ability of", this.cookingAbility + "/5.");
  }
  
  void groceryShop(Food[] gl, int currentDay) {
    print(this.name + ", you went out to get groceries for the dorm! Here's your grocery list: ");
    
    for (int i = 0; i < gl.length; i++) {
      print(gl[i].name);
      
      if (i < (gl.length - 1))
        print(", ");
    }
    
    println();
    
    ArrayList<Food> purchasedItems = new ArrayList<Food>();
    ArrayList<Food> nonPurchasedItems = new ArrayList<Food>();
    
    for (int i = 0; i < gl.length; i++) {
      if (gl[i].locationStored.containedFoodItems.size() < gl[i].locationStored.capacity) {
        purchasedItems.add(gl[i]);
        
        gl[i].purchaseDays.append(currentDay);
        gl[i].isOwned = true;
        gl[i].locationStored.containedFoodItems.add(gl[i]);
      }
      
      else
        nonPurchasedItems.add(gl[i]);
    }
    
    if (purchasedItems.size() == 0) {
      println("You couldn't buy anything because there is no more storage space at the dorm. Consider using some of the food that you already own first.");
    }
    
    else {
      print("Here's what you bought: ");
      
      for (int i = 0; i < purchasedItems.size(); i++) {
        print(purchasedItems.get(i).name);
        
        if (i < (purchasedItems.size() - 1)) {
          print(", ");
        }
      }
      
      println();
      
      if (nonPurchasedItems.size() > 0);
        for (int i = 0; i < nonPurchasedItems.size(); i++) {
        println("There's no more space in the", nonPurchasedItems.get(i).locationStored.name, "for another item, so you had to put the", nonPurchasedItems.get(i).name, "back.");
      }
    }
  
    println();
  }
  
  void cookMeal(Recipe r, int currentDay) {
    int i = 0;
    boolean canBeCooked = true;
    
    while (canBeCooked == true && i < r.ingredients.size()) {
      if (r.ingredients.get(i).isOwned == true) {
        if (r.ingredients.get(i).isExpiredInternal(currentDay) == 1) {
          i++;
        }
        
        else {
          canBeCooked = false;
          println(this.name + ", you cannot make", r.name, "because some of the required ingredients have gone bad.");
        }
      }
      
      else {
        canBeCooked = false;
        println(this.name + ", you cannot make", r.name, "because you don't own all of the required ingredients.");
      }
    }
    
    if (canBeCooked == true) {
      for (int j = 0; j < r.ingredients.size(); j++) {
        int k = 0;
        boolean[] isEachServingExpired = r.ingredients.get(j).checkExpiryInternal(currentDay);
        
        while (isEachServingExpired[k] == true)
          k++;
          
        r.ingredients.get(j).purchaseDays.remove(k);
        
        int indexToRemove = r.ingredients.get(j).getIndex(r.ingredients.get(j));
        r.ingredients.get(j).locationStored.containedFoodItems.remove(indexToRemove);
      }
      
      if (this.cookingAbility < r.difficultyLevel)
        println(this.name + ", you screwed up making the", r.name, "because your cooking ability was not up to par with the dish's difficulty level! The result? Inedible.");
      
      else 
        println(this.name + ", you have successfully made", r.name + "! The result is incredible.");
    }
    
    println();
  }
}
