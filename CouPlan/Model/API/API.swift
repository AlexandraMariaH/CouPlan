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
        static let xRapidAPIKey = "7ed6992754mshb85748fb70b9e62p1d64ecjsn02e38bbdbdef"
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
                    print("DAAtadict1", jsonDataDict)

                    print("DAAtadictfirst", jsonDataDict.first?.value)
                 //   print("DAAtadictlast", jsonDataDict.keys?.value)

                    print("DAAtadict", jsonDataDict.keys)
                    print("DAAtadictv", jsonDataDict.values)
                    print("DAAtadictv2", jsonDataDict.values.first)
                    //print("DAATASUC", jsonDataDict.values["statusCode"])

                    /*if (jsonDataDict.values.contains(Success) != true) {
                        DispatchQueue.main.async {
                        completion(nil, error)
                        }
                        return
                    }*/
                    
                  /*  if jsonDataDict.values.first as! String != "Sucess"  {
                       // task.resume()
                        //return task
                        
                        DispatchQueue.main.async {
                        completion(nil, error)
                        }
                        return
                    }*/

                }
            
            }
            catch {}
            
            print("DATAAA", data.isEmpty)
            
            do {
            let imageData = try! JSONDecoder().decode(RecipeResponse.self, from: data)
            print("IMAGEDATA", imageData)
                
            DispatchQueue.main.async {
            completion(imageData as! ResponseType, error)
            }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
          /*  catch {
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
            }*/
            
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
