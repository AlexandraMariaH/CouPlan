//
//  Client.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

import Foundation
import UIKit

class API {
    
    struct API {
        static let apiKey = "7ed6992754mshb85748fb70b9e62p1d64ecjsn02e38bbdbdef"
    }
    
    enum Endpoints {
        static let base = "https://instagram47.p.rapidapi.com"
        
        case getLatestRecipe
        //case getAllRecipes
        
        var stringValue: String {
            switch self {
            case .getLatestRecipe:
                return Endpoints.base + "/public_user_posts"
                
/*            https://example.p.rapidapi.com/?rapidapi-key=***************************
 
 https://instagram47.p.rapidapi.com/public_user_posts?userid=17632768/?rapidapi-key=7ed6992754mshb85748fb70b9e62p1d64ecjsn02e38bbdbdef
 
 https://instagram47.p.rapidapi.com/public_user_posts?userid=17632768
 
 */
            //case .getAllRecipes:
                //return Endpoints.base + ""
            }
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
    /*class func requestRecipesList(completionHandler: @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getAllRecipes.url) { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let recipesResponse = try! decoder.decode(RecipesListResponse.self, from: data)
            let recipes = recipesResponse.message.keys.map({$0})
            completionHandler(recipes, nil)
        }
        task.resume()
    }*/
    
    class func trying(url: URL, completion: @escaping (Data?, Error?) -> Void) {

        let headers = [
            "x-rapidapi-host": "instagram47.p.rapidapi.com",
            "x-rapidapi-key": "7ed6992754mshb85748fb70b9e62p1d64ecjsn02e38bbdbdef"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://instagram47.p.rapidapi.com/public_user_posts?userid=1718924098")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
    class func requestLatestImage(completionHandler: @escaping (RecipeImage?, Error?) -> Void) {
        let latestImageEndpoint = Endpoints.getLatestRecipe.url
        let task = URLSession.shared.dataTask(with: latestImageEndpoint) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(RecipeImage.self, from: data)
            print(imageData)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
    
  /*  class func taskForDownloadImage(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }*/
    
}
