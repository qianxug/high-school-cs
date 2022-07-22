int day = 1;

void setup() {
  day = 0;
  
  // Creating class objects
  Cookbook myCookbook = new Cookbook("In(cr)edible Food");  
    
  Cook gordon = new Cook("Gordon Ramsay", "angry chef with a passion for idiot sandwiches", 5);
  Cook jeffrey = new Cook("Jeffrey Luo", "broke student that cannot crack an egg", 1);
  Cook leo = new Cook("Leo You", "aspiring baker that made scrambled eggs from souffle batter", 3);
  
  StorageLocation fridge = new StorageLocation("fridge", 16);
  StorageLocation pantry = new StorageLocation("pantry", 12);
  
  Food tomato = new Food("tomato", 10, fridge);
  Food chicken = new Food("chicken", 3, fridge);
  Food egg = new Food("egg", 24, fridge);
  Food rice = new Food("rice", 500, pantry);
  Food spinach = new Food("spinach", 6, fridge);
  Food strawberry = new Food("strawberry", 7, fridge);
  Food corn = new Food("canned corn", 600, pantry);
  Food milk = new Food("milk", 14, fridge);
  Food pasta = new Food("pasta", 400, pantry);
  Food ramen = new Food("instant ramen", 400, pantry);
  Food beef = new Food("steak", 4, fridge);
  Food asparagus = new Food("asparagus", 5, fridge);
  Food flour = new Food("flour", 200, pantry);
  
  Food[] tomatoEggRiceIngredients = {tomato, egg, rice};
  Food[] chickenPastaIngredients = {chicken, pasta, milk, spinach};
  Food[] instantRamenIngredients = {ramen};
  Food[] scrambledEggIngredients = {egg};
  Food[] steakVegetableIngredients = {beef, asparagus, corn};
  Food[] strawberryCakeIngredients = {strawberry, flour, egg, milk};
  
  Recipe tomatoEggRice = new Recipe("stir-fried tomato and egg on rice", 2, tomatoEggRiceIngredients);
  Recipe chickenPasta = new Recipe("chicken fettuccine alfredo", 3, chickenPastaIngredients);
  Recipe scrambledEgg = new Recipe("scrambled egg", 2, scrambledEggIngredients);
  Recipe instantRamen = new Recipe("instant ramen", 1, instantRamenIngredients);
  Recipe steakVegetable = new Recipe("steak with vegetables", 5, steakVegetableIngredients);
  Recipe strawberryCake = new Recipe("strawberry Shortcake", 4, strawberryCakeIngredients);
  
  myCookbook.addRecipe(tomatoEggRice);
  myCookbook.addRecipe(chickenPasta);
  myCookbook.addRecipe(scrambledEgg);
  myCookbook.addRecipe(instantRamen); 
  myCookbook.addRecipe(steakVegetable);
  myCookbook.addRecipe(strawberryCake);
  
  introduce(gordon, jeffrey, leo);    // To clarify: since the three people live together, they share one pantry and one fridge. That means if one person fills up the fridge, no one else can put stuff in unless they throw the first person's stuff out first.
  
  // DAY 1:
  incrementDays();
  
  myCookbook.outputContent();
  
  leo.cookMeal(steakVegetable, day);
  pantry.checkStock();
  fridge.checkStock();
  myCookbook.checkAvailableRecipes(day);
  
  Food[] groceryList1 = {pasta, spinach, egg, milk, asparagus, rice, tomato, chicken, chicken, chicken, beef, corn};    // Here, chicken is listed three times, meaning that Gordon wants to buy three servings of chicken (can be used three times)
  gordon.groceryShop(groceryList1, day);
  pantry.checkStock();
  fridge.checkStock();
  
  // DAY 2:
  incrementDays();
  
  spinach.checkExpiry(day);
  strawberry.checkExpiry(day);
  
  leo.cookMeal(chickenPasta, day);
  
  fridge.checkStock();
  pantry.checkStock();
  
  // DAY 3:
  incrementDays();
  
  Food[] groceryList2 = {ramen, ramen, ramen, ramen, ramen, ramen, ramen, ramen, ramen, ramen};
  jeffrey.groceryShop(groceryList2, day);
  
  gordon.cookMeal(strawberryCake, day);
  
  // DAY 4:
  incrementDays();
  
  Food[] groceryList3 = {flour, egg, milk, strawberry, chicken, chicken, asparagus};
  gordon.groceryShop(groceryList3, day);
  
  pantry.checkStock();
  ramen.isThrownOut();    // When throwing out food, the program gets rid of the item(s) with the nearest expiry date by default by removing them from the front of the ArrayList
  ramen.isThrownOut();
  
  Food[] groceryList4 = {flour};
  gordon.groceryShop(groceryList4, day);
  
  jeffrey.cookMeal(instantRamen, day);
  jeffrey.cookMeal(scrambledEgg, day);
  
  // DAY 5:
  incrementDays();
  
  gordon.cookMeal(strawberryCake, day);
  
  Food[] groceryList5 = {pasta, spinach, milk};
  leo.groceryShop(groceryList5, day);
  
  // DAY 6:
  incrementDays();
  
  jeffrey.cookMeal(steakVegetable, day);
  myCookbook.checkAvailableRecipes(day);

  chicken.checkExpiry(day);    
  chicken.isThrownOut();
  chicken.checkExpiry(day);    // As aforementioned, the program will thrown out expired chicken before non-expired.
  
  leo.cookMeal(chickenPasta, day);    // At this moment, not all expired servings of chicken have been thrown out. When Leo cooks chickenPasta, the program automatically uses the oldest non-expired serving of chicken.
  chicken.checkExpiry(day);
  
  chicken.isThrownOut();
  chicken.checkExpiry(day);
}

void introduce(Cook gordon, Cook jeffrey, Cook leo) {
  println("In an interesting turn of events, three individuals move in together as they begin their studies in the Science Behind Egg Cracking at the University of Northern Quebec. Allow me to introduce them:");
  print("- ");
  gordon.introduce();
  print("- ");
  jeffrey.introduce();
  print("- ");
  leo.introduce();
  println("And what about me, you ask? Well, I'm an intelligent computer program who is here to help them make rational decisions when it comes to cooking. Without further ado, let the fun begin!");
  println();
}

void incrementDays() {
  delay(5000);
  println("***********************************************************************************************************************************************");
  day += 1;
  println("Day", day + ":");
  println("------");
}
