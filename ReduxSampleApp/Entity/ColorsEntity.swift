//
//  ColorsEntity.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//
//  Document
//  https://www.thecolorapi.com/docs
//

import Foundation

class ColorsEntity: Decodable {
    let colors: [ColorEntity]
    
    private enum CodingKeys: String, CodingKey {
        case colors
    }
    
    init() {
        colors = []
    }
}
