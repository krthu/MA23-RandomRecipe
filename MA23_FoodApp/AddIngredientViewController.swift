//
//  AddIngredientViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-19.
//

import UIKit

class AddIngredientViewController: UIViewController {

    @IBOutlet weak var ingredientContainer: UIStackView!
    @IBOutlet weak var addIngredientInput: UITextField!
    
    var ingredients : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for ingredient in ingredients{
            addIngredientLabel(ingredient: ingredient)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addIngredientButton(_ sender: Any) {
        if let ingredient = addIngredientInput.text{
            ingredients.append(ingredient)
            addIngredientLabel(ingredient: ingredient)
            addIngredientInput.text = ""
//            let label = UILabel()
//            label.text = ingredient
//            label.textAlignment = .left
//            
//            label.layer.borderWidth = 1.0
//            label.layer.borderColor = UIColor.red.cgColor
//    //        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
//    //        label.heightAnchor.constraint(equalToConstant: 10).isActive = true
//            
//            
//            ingredientContainer.addArrangedSubview(label)
//            ingredientContainer.layoutIfNeeded()
        }

        
    }
    
    func addIngredientLabel(ingredient: String){
        let label = UILabel()
        label.text = ingredient
        label.textAlignment = .left
        
     //   label.layer.borderWidth = 1.0
     //   label.layer.borderColor = UIColor.red.cgColor
        ingredientContainer.addArrangedSubview(label)
        ingredientContainer.layoutIfNeeded()
    }

    

}
