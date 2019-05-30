//
//  ColorDetailState.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

struct ColorDetailState: ReSwift.StateType {
    var heroId: String = ""
    
    enum RequestState {
        case initial
        case loading
        case success
        case error
    }
    var request: RequestState = .initial
    
    var color: ColorEntity = ColorEntity()
    var monochromeColors: ColorsEntity = ColorsEntity()
}
