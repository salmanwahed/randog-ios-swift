//
//  DogAPI.swift
//  Randog
//
//  Created by Salman Wahed on 2/23/20.
//  Copyright © 2020 Mac Mini. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case randomImgFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestImgFile(imageURL url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error )
                print("Error setting image data")
                return
            }
            let downloadedImg = UIImage(data: data)
            completionHandler(downloadedImg, nil)
        }
        task.resume()
    }
}
