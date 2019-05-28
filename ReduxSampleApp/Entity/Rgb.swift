//
//  Rgb.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import Foundation

class Rgb: Decodable {
    let r: Int
    let g: Int
    let b: Int
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case r
        case g
        case b
        case value
    }
    
    init() {
        r = 0
        g = 0
        b = 0
        value = ""
    }
}
