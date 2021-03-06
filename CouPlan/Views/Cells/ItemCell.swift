//
//  ItemCell.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 27.09.21.
//

import UIKit

internal final class ItemCell: UITableViewCell, Cell {
    // Outlets

    @IBOutlet weak var checkBoxButton: CheckBoxButton!
    @IBOutlet weak var textPreviewLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        textPreviewLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
