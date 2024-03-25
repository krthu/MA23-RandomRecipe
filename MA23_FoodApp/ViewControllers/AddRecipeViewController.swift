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
    
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var ingredientsButton: UIButton!
 
    @IBOutlet weak var recipeNameTextField: UITextField!
    let pickerView = UIPickerView()
    let toolbar = UIToolbar()
    var ingredients : [String] = []
    let goToIngredientSegue = "toAddIngredientsSegue"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBorderToTextView(textView: recipeDescriptionTextView)
        recipeNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        setIngredientsButtonText()
        setupPickerView()

        
    }
    
    @IBAction func ingredientsButtonPress(_ sender: UIButton) {
        performSegue(withIdentifier: goToIngredientSegue, sender: self)
    }
    @IBAction func saveButtonPress(_ sender: UIButton) {
//        let selectedRow = categoriePicker.selectedRow(inComponent: 0)
//        let category = book.categories[selectedRow]

        if let name = recipeNameTextField.text,
          let category = categoryInput.text,
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
        //categoriePicker.selectRow(0, inComponent: 0, animated: true)
        categoryInput.text = ""
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

        }
    }
    
  
    @IBAction func unwindToParentViewController(_ unwindSegue: UIStoryboardSegue) {
        if let fromVC = unwindSegue.source as? AddIngredientViewController{
            ingredients = fromVC.ingredients
            setIngredientsButtonText()
        }
    }
    
    func setupPickerView(){
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryInput.inputView = pickerView
        categoryInput.inputAccessoryView = toolbar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.sizeToFit()
    }
    
    @objc func doneButtonTapped() {
        // Dölj UIPickerView genom att avsluta redigering av textfältet
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedCategory = book.categories[selectedRow]
        categoryInput.text = selectedCategory
        categoryInput.endEditing(true)
    }
}

