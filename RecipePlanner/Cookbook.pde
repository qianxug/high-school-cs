class Cookbook {
  String name;
  ArrayList<Recipe> containedRecipes = new ArrayList<Recipe>();
  
  Cookbook(String n) {
    this.name = n;
  }
  
  void addRecipe(Recipe r) {
    containedRecipes.add(r);
  }
  
  void outputContent() {
    println("Here is a list of all of the recipes included in the cookbook", this.name + ":");
    
    for (int i = 0; i < this.containedRecipes.size(); i++) {
      print("- ");
      println(this.containedRecipes.get(i).listIngredients());
    }
    
    println();
  }
  
  void checkAvailableRecipes(int currentDay) {
    ArrayList<Recipe> availableRecipes = new ArrayList<Recipe>();
    
    for (int i = 0; i < this.containedRecipes.size(); i++) {
      int numberOfAvailableIngredients = 0;
      
      for (int j = 0; j < this.containedRecipes.get(i).ingredients.size(); j++) {
        if (this.containedRecipes.get(i).ingredients.get(j).isOwned == true && this.containedRecipes.get(i).ingredients.get(j).isExpiredInternal(currentDay) == 1)
          numberOfAvailableIngredients++;
      }
      
      if (numberOfAvailableIngredients == this.containedRecipes.get(i).ingredients.size())
        availableRecipes.add(this.containedRecipes.get(i));
    }
    
    if (availableRecipes.size() > 0) {
      print("Based on the non-expired ingredients available at your house right now, here is a list of the recipes from", this.name, "that you can make: ");
      
      for (int i = 0; i < availableRecipes.size(); i++) {
        print(availableRecipes.get(i).name);
        
        if (i < (availableRecipes.size() - 1))
          print(", ");
      }
      
      println();
    }
    
    else 
      println("You can't make any recipes in", this.name + ", either because you don't own all of the required ingredients at the dorm or because the required ingredients have expired! Quick, run to the store and grab some groceries.");
    
      println();
  }
}
