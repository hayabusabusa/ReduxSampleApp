//
//  ColorEntity.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import Foundation

class ColorEntity: Decodable {
    let hex: Hex
    let rgb: Rgb
    let name: Name
    
    private enum CodingKeys: String, CodingKey {
        case hex
        case rgb
        case name
    }
    
    init() {
        hex = Hex()
        rgb = Rgb()
        name = Name()
    }
}
