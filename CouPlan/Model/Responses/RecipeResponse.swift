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
    let node: Node
}

struct Node: Decodable {
    let __typename: String
    let comments_disabled: Int
    let dash_info: [Dashinfo]
    let dimensions: [Dimensions]
    let display_resources: [Displayresources]
    let display_url: String
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
}

extension RecipeResponse: LocalizedError {
    var errorDescription: String? {
        return "Error"
    }
}
