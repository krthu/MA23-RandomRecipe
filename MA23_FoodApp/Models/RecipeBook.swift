//
//  RecipeBook.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-18.
//

import Foundation
class RecipeBook{
    var recipes: [Recipe]
    var categories = ["Fish", "Meat", "Vegiterian", "Soup", "Desert", "Bread"]
    
    init(recipes: [Recipe] = []) {
        self.recipes = recipes
    }
    
    func getRandomRecipe() -> Recipe?{
        return recipes.randomElement()
    }
    
}
