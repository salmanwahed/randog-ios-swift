//
//  DogAPI.swift
//  Randog
//
//  Created by Salman Wahed on 2/23/20.
//  Copyright © 2020 Mac Mini. All rights reserved.
//

import Foundation

class DogAPI {
    enum Endpoint: String {
        case randomImgFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
}
