//
//  RecipeTableViewCell.swift
//  MA23_FoodApp
//
//  Created by Kristian Thun on 2024-03-26.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ingredientCountLabel: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
