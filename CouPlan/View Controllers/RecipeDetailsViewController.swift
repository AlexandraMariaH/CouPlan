//
//  RecipeDetailsViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 11.10.21.
//

import Foundation
import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        handle()
    }
    
    let headers = [
        "x-rapidapi-host": "instagram47.p.rapidapi.com",
        "x-rapidapi-key": "HEERE"
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://instagram47.p.rapidapi.com/public_user_posts?userid=17632768")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    
    func handle() {
        
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
    }
}



// // // ONLY IMAGE /////////////////////
/*
 let imageLocation = TestEnum.http.rawValue
 
 guard let imageUrl = URL(string: imageLocation) else {
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
 
 print("KKK", data)
 
 print("LLL", data.first)
 
 print("SSS", downloadedImage)
 
 self.imageView.image = downloadedImage
 }
 }
 task.resume()
 */


//let downloadedImage = UIImage(data: dataT)

//self.imageView.image = downloadedImage

//print("TESTDA", dataT.first)

//print("TESTD", downloadedImage)


// // // response object /////////////////////
/*   let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
 if (error != nil) {
 print(error)
 } else {
 let httpResponse = response as? HTTPURLResponse
 // print("RESPONSE", httpResponse)
 }
 
 guard let data = data else {
 print("no data, or there was an error")
 return
 }
 
 let decoder = JSONDecoder()
 let imageData = try! decoder.decode(RecipesListResponse.self, from: data)
 
 /*do {
  let imageData = try decoder.decode(RecipeResponse.self, from: data)
  print(imageData)
  
  } catch {
  print("NICE")
  }*/
 
 
 let downloadedImage = UIImage(data: data)
 
 self.imageView.image = downloadedImage
 
 print("TESTDA", data.first)
 
 print("TESTD", downloadedImage)
 
 })
 
 dataTask.resume()
 
 }
 }*/

