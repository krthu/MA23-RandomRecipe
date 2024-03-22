//
//  FindRecipeViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-18.
//

import UIKit

class FindRecipeViewController: UIViewController  {
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
//        guard let customPopupVC = storyboard?.instantiateViewController(withIdentifier: "CustomPopupViewController") as? CustomPopupViewController else {
//            return
//        }
//        customPopupVC.modalPresentationStyle = .overCurrentContext // Visa den som en popup
//        
//        present(customPopupVC, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func findRecipeButtonPress(_ sender: UIButton) {
        //print("Category: \(chosenCategory) Ingredient: \(mustIncludeIngredientTextView.text)")
        var recipe: Recipe?
        if let mustIncludeIngredient = mustIncludeIngredientTextView.text{
            if !mustIncludeIngredient.isEmpty{
                if let chosenCategory = chosenCategory{
                    print("CheckBoth")
                    recipe = book.getRandomRecipe(withCategory: chosenCategory, mustIncludeIngredient: mustIncludeIngredient)
                }else{
                    print("Check ingredient")
                    recipe = book.getRandomRecipe(mustIncludeIngredient: mustIncludeIngredient)
                }
            } else if let chosenCategory = chosenCategory{
                recipe = book.getRandomRecipe(withCategory: chosenCategory)
                print("Check category")
            } else{
                print("Check none")
                recipe = book.getRandomRecipe()
            }
            
            if let recipe = recipe{
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
    
    //    func setupPickerView(){
    //        pickerView.delegate = self
    //        pickerView.dataSource = self
    //        categoryInput.inputView = pickerView
    //        categoryInput.inputAccessoryView = toolbar
    //        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
    //        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    //        toolbar.setItems([spaceButton, doneButton], animated: false)
    //        toolbar.sizeToFit()
    //    }
    
    
    func displayCategoryMenu() {
        let alertController = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        
        for category in book.categories {
            let action = UIAlertAction(title: category, style: self.chosenCategory == category ? .destructive: .default) { [weak self] action in
                
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
        
        // label.layer.borderWidth = 1.0
        // label.layer.borderColor = UIColor.red.cgColor
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
    
    
    class CustomPopupViewController: UIViewController {
        
        @IBOutlet weak var contentView: UIView! // Anpassad innehållsvy
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Designa och anpassa utseendet på contentView
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
            contentView.backgroundColor = .white
            
            // Visa en animation för att rutan ska komma uppifrån
            contentView.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
            UIView.animate(withDuration: 0.5) {
                self.contentView.transform = .identity
            }
        }
        
        @IBAction func closePopup(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
    }

    
    

