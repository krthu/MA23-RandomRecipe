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
    
    func getRandomRecipe(inCategory: String) -> Recipe?{
        let filteredRecipies = recipes.filter{$0.category == inCategory}
        return filteredRecipies.randomElement()
        
    }
    
    func getRandomRecipe(mustIncludeIngredient: String) -> Recipe?{
        let filterdRecipies = recipes.filter{ recipe in
            return recipe.ingredients.contains{ ingredient in
                return ingredient.lowercased() == mustIncludeIngredient.lowercased()
                
            }
        }
        return filterdRecipies.randomElement()
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
