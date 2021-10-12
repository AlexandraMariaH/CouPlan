//
//  PostResponse.swift
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
        case indexNull = "Index 0"
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
    

   

