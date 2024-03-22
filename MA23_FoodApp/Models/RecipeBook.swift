//
//  RecipeBook.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-18.
//

import Foundation
class RecipeBook{
    private var recipes: [Recipe]
    var categories = ["Fish", "Meat", "Vegiterian", "Soup", "Desert", "Bread"]
    let defaultsKey = "recipes"
    
    init(recipes: [Recipe] = []) {
        self.recipes = recipes
    }
    
    func getRandomRecipe() -> Recipe?{
        return recipes.randomElement()
    }
    
    func getRandomRecipe(withCategory: String) -> Recipe?{
//        let filteredRecipies = recipes.filter{$0.category == inCategory}
        let filteredList = filterList(onCategory: withCategory, list: recipes)
        return filteredList.randomElement()
        
    }
    
    func getRandomRecipe(withCategory: String, mustIncludeIngredient: String) -> Recipe?{
        let categoryFilteredList = filterList(onCategory: withCategory, list: recipes)
        let ingredientFilteredList = filterList(mustIncludeIngredient: mustIncludeIngredient, list: categoryFilteredList)
        return ingredientFilteredList.randomElement()
        
    }
    
    func getRandomRecipe(mustIncludeIngredient: String) -> Recipe?{
//        let filterdRecipies = recipes.filter{ recipe in
//            return recipe.ingredients.contains{ ingredient in
//                return ingredient.lowercased() == mustIncludeIngredient.lowercased()
//                
//            }
//        }
        let filteredList = filterList(mustIncludeIngredient: mustIncludeIngredient, list: recipes)
        return filteredList.randomElement()
    }
    
    func filterList(onCategory: String, list: [Recipe]) -> [Recipe]{
        let filteredRecipies = list.filter{$0.category == onCategory}
        return filteredRecipies
    }
    
    func filterList(mustIncludeIngredient: String, list: [Recipe]) -> [Recipe]{
        let filterdRecipies = list.filter{ recipe in
            return recipe.ingredients.contains{ ingredient in
                return ingredient.lowercased() == mustIncludeIngredient.lowercased()
                
            }
        }
        return filterdRecipies
    }
    
    
    
    
    func addRecipe(recipe: Recipe){
        recipes.append(recipe)
        saveRecipeBookToUserDefaults()
    }
    
    func getAmountOfRecipies() -> Int{
        return recipes.count
    }
    
    func saveRecipeBookToUserDefaults(){
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(recipes)
            UserDefaults.standard.set(data, forKey: defaultsKey)
        }
            catch{
                print("Error saveing", error)
        }
    }
    
    
    func loadRecipes(){
        if let data = UserDefaults.standard.data(forKey: defaultsKey){
            do{
                let decoder = JSONDecoder()
                recipes = try decoder.decode([Recipe].self, from: data)
                print("Read recipies")
            } catch{
                print("Error reading data", error)
            }
        }
    }
    
    func printAllRecipies(){
        for recipe in recipes {
            print(recipe)
        }
    }
    
    func eraseUserDeafults(){
        UserDefaults.standard.removeObject(forKey: defaultsKey)
    }
    
}
