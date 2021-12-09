//
//  API.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

import Foundation
import UIKit

class API {
    
    struct API {
        static let xRapidAPIKey = ""
    }
    
    enum Endpoints {
        static let rapidAPIUrl = "https://instagram47.p.rapidapi.com/public_user_posts?userid=17632768"
        
        case getURL
        
        var stringValue: String {
            switch self {
                
            case .getURL:
                return Endpoints.rapidAPIUrl
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        let request = NSMutableURLRequest(url: NSURL(string: Endpoints.getURL.stringValue)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        let headers = [
            "x-rapidapi-host": "instagram47.p.rapidapi.com",
            "x-rapidapi-key": API.xRapidAPIKey
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { data, response, error in
            
            print("DAATA", data?.first)
            
            guard let data = data else {
                DispatchQueue.main.async {
                completion(nil, error)
                }
                return
            }
            do {
                if let jsonDataDict  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                    NSLog("Received data:\n\(jsonDataDict))")
                    print("DAAtadi", jsonDataDict)

                }
            
            }
            catch {}
                        
            do {
            let imageData = try JSONDecoder().decode(ResponseType.self, from: data)
                
            DispatchQueue.main.async {
                completion(imageData, nil)
            }
            } catch {
                do {
                    let errorResponse = try JSONDecoder().decode(RecipeResponse.self, from: data) as Error
                DispatchQueue.main.async {
                    completion(nil, errorResponse)
                }
                    
            }
                catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
            
        }
        
        task.resume()
        return task
    }
    
    class func downloadRecipe(completion:@escaping (RecipeResponse?, Error?) -> Void) {
        
        taskForGETRequest(responseType: RecipeResponse.self){
            (response,error) in
            
            print("RESPONSEbef", response)

            
            if let response = response {
                DispatchQueue.main.async {
                    completion(response, nil)
                    
                    print("RESPONSE", response)
                }
            } else {
                DispatchQueue.main.async {
                    completion(response, error)
                }
            }
        }
    }
    
    class func getPhotoURL() -> String {
        let urlString =  NSURL(string: Endpoints.getURL.stringValue)! as URL
        return urlString.absoluteString
    }
    
    class func requestImage(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            print("URLL2", url, data, response?.url)
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
          //  completionHandler(data, nil)
            
            let imageFile = UIImage(data: data)
            completionHandler(imageFile, nil)
        })
        task.resume()
    }
    
    //for recipesviewController as setup
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
