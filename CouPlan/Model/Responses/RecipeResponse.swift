//
//  RecipeResponse.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

import Foundation

/*struct RecipesListResponse: Codable {
    let status: String
   // let message: [String: [String]]
  //  let body: String
    let body: [String: [String]]
    let statusCode: Int

}*/

struct RecipesListResponse: Decodable {
    let body: Body
    let status: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case body = "body"
        case status = "status"
        case statusCode = "statusCode"
    }
}

struct Body: Decodable {
    let count: Int
    let edges: [Edges]
    let page_info: [String: [String]]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case edges = "edges"
        case page_info = "page_info"
    }
}

struct Edges: Decodable {
    let indexNull: Index
    
    
    enum CodingKeys: String, CodingKey {
        case indexNull = "Intzzz"
    }
}

struct Index: Decodable {
    let node: Node
    
    enum CodingKeys: String, CodingKey {
        case node = "node"
    }
}

struct Node: Decodable {
    let __typename: String
    let comments_disabled: Bool
}

struct PageInfo: Decodable {
    let end_cursor: String
    let has_next_page: Bool
}

/*struct RecipesListResponse: Decodable {
    
    struct Body: Decodable {
        var count: Int
        var edges: [Edges]
        var page_info: [String: [String]]
        
    }
    
    struct Edges: Decodable {
        let indexNull: Index
        
        enum CodingKeys: String, CodingKey {
            case indexNull = "Index 0"
        }
    
    var body: Body
    var status: String
    var statusCode: Int
}*/
    

   
/*struct RecipeResponse: Decodable {
    let body: Body
    let statusCode: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case body = "body"
        case statusCode = "statusCode"
        case status = "status"
    }
}

struct Body: Decodable {
    let count: Int
    let edges: [Edges]
    let page_info: [String: [String]]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case edges = "edges"
        case page_info = "page_info"
    }
}

struct Edges: Decodable {
    let node: [Node]
}

struct Node: Decodable {
    let __typename: String
    let comments_disabled: Int
    let dash_info: [Dashinfo]
    let dimensions: [Dimensions]
    let display_resources: [Displayresources]
}

struct Dashinfo: Decodable {
    let is_dash_eligible: Int
    let number_of_qualities: Int
    let video_dash_manifest: String
}

struct Dimensions: Decodable {
    let height: Int
    let width: Int
}

struct Displayresources: Decodable {
    let config_height: Int
    let config_width: Int
    let src: String
}


//...


struct PageInfo: Decodable {
    let end_cursor: String
    let has_next_page: Int
}*/
