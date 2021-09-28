//
//  Cell.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 27.09.21.
//

import UIKit

protocol Cell: AnyObject {
    /// A default reuse identifier for the cell class
    static var defaultReuseIdentifier: String { get }
}

extension Cell {
    static var defaultReuseIdentifier: String {
        // Should return the class's name, without namespacing or mangling.
        // This works as of Swift 3.1.1, but might be fragile.
        return "\(self)"
    }
}
