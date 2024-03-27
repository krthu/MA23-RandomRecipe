//
//  DetailsRecipeViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-25.
//

import UIKit

class DetailsRecipeScrollViewController: UIViewController {
    var recipe : Recipe?

    @IBOutlet weak var ingredientVstack: UIStackView!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var descritpionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var navbar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
//        ingredientTextView.layer.borderWidth = 1.0
//        ingredientTextView.layer.cornerRadius = 10
//        ingredientTextView.layer.borderColor = UIColor.black.cgColor
//        
//        
        recipeNameLabel.text = recipe?.name
        categoryLabel.text = recipe?.category
        descritpionTextView.text = recipe?.description
        if let ingredients = recipe?.ingredients{
            for ingredient in ingredients{
                let label = UILabel()
                label.text = ingredient
                label.heightAnchor.constraint(equalToConstant: 30).isActive = true
                label.backgroundColor = .white
//                label.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                label.layer.borderWidth = 1.0
                label.layer.cornerRadius = 2
                label.layer.borderColor = UIColor.lightGray.cgColor
                ingredientVstack.addArrangedSubview(label)
            }

        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
