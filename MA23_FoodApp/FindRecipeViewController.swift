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
    

    @IBOutlet weak var mustIncludeIngredientTextView: UITextField!
    @IBOutlet weak var ingredientContainer: UIStackView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    @IBOutlet weak var recipeDescriptionLable: UILabel!
    @IBOutlet weak var recipeCategoryLable: UILabel!
    var chosenCategory: String? = nil
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(book.getAmountOfRecipies())
        recipeDescriptionTextView.layer.borderWidth = 1.0
        recipeDescriptionTextView.layer.cornerRadius = 5.0
        recipeDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        
//        updateMenu()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func openCategoryMenuButtonPress(_ sender: Any) {
        displayCategoryMenu()
    }
    
    
    @IBAction func findRecipeButtonPress(_ sender: UIButton) {
        
        
        if let chosenCategory = chosenCategory {
            let recipe = book.getRandomRecipe(inCategory: chosenCategory)
            if let recipe = recipe {
                addRecipeToUI(recipe: recipe)
            }
        }else if let mustInclude = mustIncludeIngredientTextView.text{
            let recipe = book.getRandomRecipe(mustIncludeIngredient: mustInclude)
            if let recipe = recipe{
                addRecipeToUI(recipe: recipe)
            }
            
        }
        
        
        
        else{
            let recipe = book.getRandomRecipe()
            if let recipe = recipe {
                addRecipeToUI(recipe: recipe)
            }
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
            let action = UIAlertAction(title: category, style: self.chosenCategory == category ? .destructive: .default) { [weak self] action in
//                if self?.chosenCategory == category{
//                    
//                    action.setValue(true, forKey: "preferred")
//                    let image = UIImage(named: "checkmark")
//                    action.setValue(image, forKey: "image")
             //   }
                
                self?.chosenCategory = category
                self?.setCategory(category: category)
            }
            
            
            
            alertController.addAction(action)
        }
        let clearAction = UIAlertAction(title: "Clear", style: .default){ _ in
            self.chosenCategory = nil
            self.setCategory(category: "")
        }
        alertController.addAction(clearAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func addRecipeToUI(recipe: Recipe){
        
        removeIngredients()
        
        recipeNameLable.text = recipe.name
        recipeCategoryLable.text = recipe.category
        recipeDescriptionTextView.text = recipe.description
        for ingredient in recipe.ingredients {
            addIngredientLabel(ingredient: ingredient)
        }
    }
    
    func removeIngredients(){
        for label in ingredientContainer.arrangedSubviews{
            ingredientContainer.removeArrangedSubview(label)
            label.removeFromSuperview()
        }
    }
    
    func addIngredientLabel(ingredient: String){
        let label = UILabel()
        label.text = ingredient
        label.textAlignment = .left
        
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.red.cgColor
        ingredientContainer.addArrangedSubview(label)
        ingredientContainer.layoutIfNeeded()
    }
    
    func setCategory(category: String){
        categoryButton.setTitle(category, for: .normal)
    }
    @IBAction func backButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
