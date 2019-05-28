//
//  Hex.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import Foundation

class Hex: Decodable {
    let value: String
    let clean: String
    
    private enum CodingKeys: String, CodingKey {
        case value
        case clean
    }
    
    init() {
        value = ""
        clean = ""
    }
}
