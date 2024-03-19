//
//  StartViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-18.
//

import UIKit

class StartViewController: UIViewController {
    let toAddRecipeSegue = "toAddRecipeSegue"
    let toFindRecipeSegue = "toFindRecipeSegue"
    let book = RecipeBook()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        book.loadRecipes()
        print(book.getAmountOfRecipies())
        
//        let recipe = Recipe(name: "Fisk och potatis", category: "Fisk", description: "Fisk är gott ibland")
//        
//        book.addRecipe(recipe: recipe)
//        book.addRecipe(recipe: Recipe(name: "Svamppaj", category: "Svamt", description: "Svamp är också gott"))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func findButtonPress(_ sender: UIButton) {
        performSegue(withIdentifier: toFindRecipeSegue, sender: self)
    }
    
    @IBAction func addButtonPress(_ sender: UIButton) {
        book.saveRecipeBookToUserDefaults()
        performSegue(withIdentifier: toAddRecipeSegue, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toAddRecipeSegue{
            if let destinationVC = segue.destination as? AddRecipeViewController{
                destinationVC.book = book
            }
        }else if segue.identifier == toFindRecipeSegue{
            if let destinationVC = segue.destination as? FindRecipeViewController{
                destinationVC.book = book
            }
        }
    }
    
    


}
