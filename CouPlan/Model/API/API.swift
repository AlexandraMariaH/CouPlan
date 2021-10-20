//
//  API.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

import Foundation

class API {
    
    let headers = [
        "x-rapidapi-host": "instagram47.p.rapidapi.com",
        "x-rapidapi-key": ""
    ]
    
    enum Endpoints {
        static let base = "https://instagram47.p.rapidapi.com"
        
        case getLatestRecipe
        //case getAllRecipes
        
        var stringValue: String {
            switch self {
            case .getLatestRecipe:
                return Endpoints.base + "/public_user_posts?userid=17632768"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
  /*  class func taskForDownloadImage(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        
        print("DOWNLOAD", url)

        task.resume()
    }*/
    
     func downloadRecipes(completion:@escaping (Node?, Error?) -> Void) {
        
        print("HEEEERE3")
         
         print("lala", Endpoints.getLatestRecipe.url)
         print("lili", Edges.self)
        
        taskForGETRequest(url: Endpoints.getLatestRecipe.url, responseType: Edges.self){
            (response,error) in
            
            print("RESPONSE", response)
            
            if let response = response {
                DispatchQueue.main.async {
                    completion(response.node, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(response?.node, error)
                }
            }
        }
    }
    
     func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        print("HEEEERE9", url)
        
        let request = NSMutableURLRequest(url: url, cachePolicy:.useProtocolCachePolicy,timeoutInterval: 10.0)
        
        //request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            print("HEEEERE10", data)

            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try JSONDecoder().decode(RecipeResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
    
   // let request = NSMutableURLRequest(url: Endpoints.getLatestRecipe.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    
   /* func taskForDownloadImage() {
        print("testAPI")
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                                                                        
                        let body = jsonDataDict["body"]
                        
                        let edges = body!["edges"]
                                                                                        
                        let jsonData = try JSONSerialization.data(withJSONObject: edges)
                        
                        let jsonString = String(data: jsonData, encoding: .utf8)
                        
                        print("EEE in edges:", jsonString ?? "Wrong data")
                                                
                        print("WWWE", type(of:jsonString!))
                        
                        let afterURL = jsonString!.components(separatedBy: "display_url\":\"")[1]
                        
                        let endcutted = afterURL.components(separatedBy: "\",\"taken_at_timestamp")[0]
                        
                        print("typeOfEndcutted", type(of:endcutted))

                        
                        let withoutBackslash = endcutted.replacingOccurrences(of: "\\", with: "")
                        print("URL", withoutBackslash)
                        
                        
                        /////////////////
                        ///
                        ///
                        ///
                        guard let imageUrl = URL(string: withoutBackslash) else {
                        print("Cannot create URL")
                        return
                        }
                        
                        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                        guard let data = data else {
                        print("no data, or there was an error")
                        return
                        }
                        let downloadedImage = UIImage(data: data)
                        DispatchQueue.main.async {
                        
                                                
                        print("SSS", downloadedImage)
                        
                        self.imageView.image = downloadedImage
                        }
                        }
                        task.resume()
                        ////////////////////
                    }
                }
                
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        
        task.resume()
    }*/
    
}
