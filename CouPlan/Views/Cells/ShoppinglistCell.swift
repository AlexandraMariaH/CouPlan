//
//  ShoppinglistCell.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 27.09.21.
//

import UIKit

internal final class ShoppinglistCell: UITableViewCell, Cell {
    // Outlets

    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }

}
