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
    enum Endpoint {
        case randomImgFromAllDogsCollection
        case randomImgByBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValues)!
        }
        
        var stringValues: String {
            switch self {
            case .randomImgFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImgByBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
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
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: DogAPI.Endpoint.randomImgFromAllDogsCollection.url){ (data, response, error) in
            guard let data = data else {
                print("No data or there was an error")
                return
            }
            let decoder = JSONDecoder()
            do{
                let dogImg = try decoder.decode(DogImage.self, from: data)
                completionHandler(dogImg, nil)
            }catch{
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    class func requestRandomImage(breed:String, completionHandler: @escaping (DogImage?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: DogAPI.Endpoint.randomImgByBreed(breed).url){ (data, response, error) in
            guard let data = data else {
                print("No data or there was an error")
                return
            }
            let decoder = JSONDecoder()
            do{
                let dogImg = try decoder.decode(DogImage.self, from: data)
                completionHandler(dogImg, nil)
            }catch{
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    class func requestAllBreedList(completionHandler: @escaping([String], Error?) ->Void){
        let task = URLSession.shared.dataTask(with: DogAPI.Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else {
                print("No data or there was an error")
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let breeds = try decoder.decode(BreedList.self, from: data)
                completionHandler(Array(breeds.message.keys), nil)
            }catch{
                completionHandler([], error)
            }
            
        }
        task.resume()
    }
}
