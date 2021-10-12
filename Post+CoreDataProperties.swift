//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Alexandra Hufnagel on 08.10.21.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var post: Data?
    @NSManaged public var url: String?

}
