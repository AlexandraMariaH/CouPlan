//
//  OneRecipeViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 11.10.21.
//

import Foundation
import UIKit

class OneRecipeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var imagev2: UIImageView!
    
   override func viewDidLoad() {
    super.viewDidLoad()
       handle()
    }

let headers = [
    "x-rapidapi-host": "instagram47.p.rapidapi.com",
    "x-rapidapi-key": "7ed6992754mshb85748fb70b9e62p1d64ecjsn02e38bbdbdef"
]

let request = NSMutableURLRequest(url: NSURL(string: "https://instagram47.p.rapidapi.com/public_user_posts?userid=1718924098")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)


func handle() {
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

    
let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
    if (error != nil) {
        print(error)
    } else {
        let httpResponse = response as? HTTPURLResponse
        print("RESPONSE", httpResponse)
    }
    
    guard let data = data else {
        print("no data, or there was an error")
        return
    }
    
    
    let decoder = JSONDecoder()
    let imageData = try! decoder.decode(RecipesListResponse.self, from: data)
 
   /* do {
         let imageData = try decoder.decode(RecipesListResponse.self, from: data)
        print(imageData)

    } catch {
        print("NICE")
    }*/
    
    
    
    
    //  let image = imageData.message.keys.map({$0})

    
    let downloadedImage = UIImage(data: data)

    self.imageView.image = downloadedImage

    print("TESTDA", data.first)

    print("TESTD", downloadedImage)
    
    
    
    
  /*  <NSHTTPURLResponse: 0x6000022ab460> { URL: https:instagram47.p.rapidapi.com/public_user_posts?userid=1718924098 } { Status Code: 200, Headers {
        "Alt-Svc" =     (
            "h3=\":443\"; ma=86400, h3-29=\":443\"; ma=86400, h3-28=\":443\"; ma=86400, h3-27=\":443\"; ma=86400");
        Connection =     (
            "keep-alive");
        "Content-Length" =     (
            67);
        "Content-Type" =     (
            "application/json");
        Date =     (
            "Mon, 11 Oct 2021 16:48:36 GMT");
        Server =     (
            "RapidAPI-1.2.8");
        "X-RapidAPI-Region" =     (
            "AWS - eu-central-1");
        "X-RapidAPI-Version" =     (
            "1.2.8");
        "X-RateLimit-Requests-Limit" =     (
            50);
        "X-RateLimit-Requests-Remaining" =     (
            47);
        "X-RateLimit-Requests-Reset" =     (
            80260);"cf-cache-status" =     (
            DYNAMIC
        );"cf-ray" =     (
            "69c993b2c95964b5-FRA");
    } }
    */
    
})

dataTask.resume()

}
    
}
