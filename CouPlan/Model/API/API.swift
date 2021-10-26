//
//  API.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

import Foundation
import UIKit

class API {
    
    class func taskForGETRequest<ResponseType: Decodable>(responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://instagram47.p.rapidapi.com/public_user_posts?userid=17632768")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        let headers = [
            "x-rapidapi-host": "instagram47.p.rapidapi.com",
            "x-rapidapi-key": ""
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { data, response, error in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                if let jsonDataDict  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                    NSLog("Received data:\n\(jsonDataDict))")
                }
            }
            catch {}
            
            let imageData = try! JSONDecoder().decode(RecipeResponse.self, from: data)
            print("IMAGEDATA", imageData)
            
            completion(nil, error)
            
        }
        
        task.resume()
        
        return task

    }
    
    class func downloadRecipe(completion:@escaping (RecipeResponse?, Error?) -> Void) {
        
        taskForGETRequest(responseType: RecipeResponse.self){
            (response,error) in
            
            if let response = response {
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(response, error)
                }
            }
        }
    }
    
    class func getPhotoURL() -> String {
        let urlString =  NSURL(string: "https://instagram47.p.rapidapi.com/public_user_posts?userid=17632768")! as URL
        return urlString.absoluteString
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            print("URLL2", url, data, response?.url)
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        })
        task.resume()
    }
    
    
}


