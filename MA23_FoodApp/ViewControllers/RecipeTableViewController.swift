//
//  RecipeTableViewController.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-25.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    
    var book : RecipeBook?
    let toDetailsRecipieSegue = "toRecipieDetailsSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = book?.getAmountOfRecipies(){
            return count
        }
        return 0
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            fatalError("Unable to dequeue RecipeTableViewCell")
        }
        let recipe = book?.getRecipe(atIndex: indexPath.row)

        if let recipe = recipe {
            cell.recipeName.text = recipe.name
            cell.ingredientCountLabel.text = "\(recipe.ingredients.count) ingridents"
            cell.categoryLabel.text = recipe.category
        }

        //cell.textLabel?.text = recipe?.name
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            book?.deleteRecipe(atIndex: indexPath.row)
            book?.saveRecipeBookToUserDefaults()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toDetailsRecipieSegue {
            if let destinationVC = segue.destination as? DetailsRecipeScrollViewController,
               let cell = sender as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell),
                let recipe = book?.getRecipe(atIndex: indexPath.row){
                destinationVC.recipe = recipe
                
            }
               
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
