//
//  ViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-18.
//

import UIKit

class AddRecipeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var book = RecipeBook()
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    
    @IBOutlet weak var ingredientsButton: UIButton!
    @IBOutlet weak var categoriePicker: UIPickerView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    var ingredients : [String] = []
    let goToIngredientSegue = "toAddIngredientsSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBorderToTextView(textView: recipeDescriptionTextView)
        recipeNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        setIngredientsButtonText()
        
    }
    
    @IBAction func ingredientsButtonPress(_ sender: UIButton) {
        performSegue(withIdentifier: goToIngredientSegue, sender: self)
    }
    @IBAction func saveButtonPress(_ sender: UIButton) {
        let selectedRow = categoriePicker.selectedRow(inComponent: 0)
        let category = book.categories[selectedRow]
        if let name = recipeNameTextField.text,
           let description = recipeDescriptionTextView.text{
            if !name.isEmpty && !description.isEmpty{
                let recipe = Recipe(name: name, category: category, description: description, ingredients: ingredients)
                book.addRecipe(recipe: recipe)
                print("recipie \(recipe) added")
                clearForm()
                print(book.getAmountOfRecipies())
            }
            
            
            
        }
    }
    
    func setIngredientsButtonText(){
        ingredientsButton.setTitle("Ingredients: \(ingredients.count)", for: .normal)
    }
    
    func clearForm(){
        recipeNameTextField.text = ""
        recipeDescriptionTextView.text = ""
        categoriePicker.selectRow(0, inComponent: 0, animated: true)
        ingredients = []
        setIngredientsButtonText()
    }
    
    
    func addBorderToTextView(textView: UITextView){
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return book.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return book.categories[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToIngredientSegue{
            if let destinationVC = segue.destination as? AddIngredientViewController{
                destinationVC.ingredients = ingredients
            }
//        
////        
////        if let destinationVC = segue.destination{
////            if
        }
    }
    
  
    @IBAction func unwindToParentViewController(_ unwindSegue: UIStoryboardSegue) {
        if let fromVC = unwindSegue.source as? AddIngredientViewController{
            ingredients = fromVC.ingredients
            setIngredientsButtonText()
        }
    }
}

