//
//  AddIngredientViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-19.
//

import UIKit

class AddIngredientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    

    
    @IBOutlet weak var addIngredientInput: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputStackConstraint: NSLayoutConstraint!
    var defaultOnputStackContsraint: Double?
    var ingredients : [String] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        defaultOnputStackContsraint = inputStackConstraint.constant
        for ingredient in ingredients{
            addIngredientLabel(ingredient: ingredient)
        }
        tableView.delegate = self
        tableView.dataSource = self
       
        
        // Do any additional setup after loading the view.
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Hantera tangentbordsevenemang när tangentbordet visas
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Justera vyens position baserat på tangentbordets höjd
            let keyboardHeight = keyboardSize.height
            // Exempel: Flytta vyn uppåt med tangentbordets höjd
            //self.view.frame.origin.y -= keyboardHeight
            inputStackConstraint.constant += keyboardHeight
            print(inputStackConstraint.constant)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Hantera tangentbordsevenemang när tangentbordet döljs
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Justera vyens position baserat på tangentbordets höjd
            let keyboardHeight = keyboardSize.height
            // Återställ vyens position till ursprungsläge
            if let defaultOnputStackContsraint = defaultOnputStackContsraint{
                inputStackConstraint.constant = defaultOnputStackContsraint
            }

        }
    }
    
    @IBAction func addIngredientButton(_ sender: Any) {
        if let ingredient = addIngredientInput.text{
            if !ingredient.isEmpty{
                ingredients.append(ingredient)
                addIngredientLabel(ingredient: ingredient)
                addIngredientInput.text = ""
                tableView.reloadData()
            }

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
//        let label = UILabel()
//        label.text = ingredient
//        label.textAlignment = .left
//        
//        label.layer.borderWidth = 1.0
//        label.layer.borderColor = UIColor.red.cgColor
//        ingredientContainer.addArrangedSubview(label)
//        ingredientContainer.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Return items count
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.item]
        
        return cell
    }


}
