//
//  Breeds.swift
//  Randog
//
//  Created by Salman Wahed on 2/25/20.
//  Copyright © 2020 Mac Mini. All rights reserved.
//

import Foundation

struct BreedList: Codable {
    let message:[String:[String]]
    let status: String
}
