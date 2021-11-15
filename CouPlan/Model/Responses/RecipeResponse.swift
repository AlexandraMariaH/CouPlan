//
//  RecipeResponse.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

import Foundation

struct RecipeResponse: Decodable {
    let body: Body
    let statusCode: Int
    let status: String
}

struct Body: Decodable {
    let edges: [Edges]
}

struct Edges: Decodable {
    let node: Node
}

struct Node: Decodable {
    let display_url: String
}

extension RecipeResponse: LocalizedError {
    var errorDescription: String? {
        return "Error"
    }
    
}

/*extension RecipeResponse {
    
    // Generate an array full of all of the recipes in
    static var allRecipes: [RecipeResponse] {
        
        var recipeArray = [RecipeResponse]()
        
        for d in RecipeResponse. {
            recipeArray.append(Recipe(dictionary: d))
        }
        
        return recipeArray
    }
}*/

