//
//  GetColorsParams.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/29.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import Foundation

struct GetColorsParams {
    let hex: String
    let count: Int
    let mode: String
    
    init(hex: String, count: Int, mode: String) {
        self.hex = hex
        self.count = count
        self.mode = mode
    }
}
