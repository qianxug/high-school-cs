class Recipe {
  String name;
  int difficultyLevel;
  ArrayList<Food> ingredients;
  
  Recipe(String n, int dl, Food[] i) {
    this.name = n;
    this.difficultyLevel = dl;
    this.ingredients = new ArrayList<Food>();
    
    addIngredients(i);
  }
  
  String listIngredients() {
    String message = this.name + ", which requires ";
    
    for (int i = 0; i < this.ingredients.size(); i++) {
      message += this.ingredients.get(i).name;
      
      if (i < (this.ingredients.size() - 1))
        message += ", ";
      
      if (i == (this.ingredients.size() - 2))
        message += "and ";
    }
  
  return message;
  }
  
  private void addIngredients(Food[] arr) {
    for (int i = 0; i < arr.length; i++) { 
      this.ingredients.add(arr[i]);
    }
  }
}
