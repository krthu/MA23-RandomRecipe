//
//  ViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-18.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let book = RecipeBook()
    var selectedCategory: String?
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    
    @IBOutlet weak var categoriePicker: UIPickerView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBorderToTextView(textView: recipeDescriptionTextView)
        recipeNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let recipe = Recipe(name: "Fisk och potatis", category: "Fisk", description: "Fisk är gott ibland")
        
        book.recipes.append(recipe)
        book.recipes.append(Recipe(name: "Svamppaj", category: "Svamt", description: "Svamp är också gott"))
        


    }
    
    @IBAction func saveButtonPress(_ sender: UIButton) {
        let selectedRow = categoriePicker.selectedRow(inComponent: 0)
        let category = book.categories[selectedRow]
        if let name = recipeNameTextField.text,
           let description = recipeDescriptionTextView.text{
            if !name.isEmpty && !description.isEmpty{
                let recipe = Recipe(name: name, category: category, description: description)
                book.recipes.append(recipe)
                print("recipie \(recipe) added")
                clearForm()
            }
            
            
            
        }
    }
    
    func clearForm(){
        recipeNameTextField.text = ""
        recipeDescriptionTextView.text = ""
        categoriePicker.selectRow(0, inComponent: 0, animated: true)
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = book.categories[row]
    }
    

}

