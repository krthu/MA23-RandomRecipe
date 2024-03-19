//
//  FindRecipeViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-18.
//

import UIKit

class FindRecipeViewController: UIViewController {
    var book = RecipeBook()
    @IBOutlet weak var recipeNameLable: UILabel!
    

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    @IBOutlet weak var recipeDescriptionLable: UILabel!
    @IBOutlet weak var recipeCategoryLable: UILabel!
    var chosenCategory: String? = nil
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(book.getAmountOfRecipies())
//        updateMenu()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func openCategoryMenuButtonPress(_ sender: Any) {
        displayCategoryMenu()
    }
    
    
    @IBAction func findRecipeButtonPress(_ sender: UIButton) {
        let recipe = book.getRandomRecipe()
        if let recipe = recipe {
            addRecipeToUI(recipe: recipe)
        }
       
    }
    @IBAction func selectCategoryButtonPress(_ sender: UIButton) {
        
        
        
    }
    
//    func updateMenu(){
//        var menuActions: [UIAction] = []
//        for category in book.categories {
//            let action = UIAction(title: category, handler: { action in
//                self.chosenCategory = category
//            })
//            menuActions.append(action)
//        }
//        
//        let menu = UIMenu(title: "Category", children: menuActions)
//        
//        categoryMenu = menu
//        
//        
//    }
    
    
    func displayCategoryMenu() {
        let alertController = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        
        for category in book.categories {
            let action = UIAlertAction(title: category, style: .default) { [weak self] action in
                if self?.chosenCategory == category{
                    action.setValue(true, forKey: "preferred")
                    let image = UIImage(named: "checkmark")
                    action.setValue(image, forKey: "image")
                }
                self?.chosenCategory = category
                self?.setCategory(category: category)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func addRecipeToUI(recipe: Recipe){
        recipeNameLable.text = recipe.name
        recipeCategoryLable.text = recipe.category
        recipeDescriptionTextView.text = recipe.description
    }
    
    func setCategory(category: String){
        categoryButton.setTitle(category, for: .normal)
    }

}
