//
//  Item+Extensions.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 27.09.21.
//

import Foundation
import CoreData

extension Item {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
