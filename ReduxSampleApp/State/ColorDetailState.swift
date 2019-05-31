//
//  ColorDetailState.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

struct ColorDetailState: ReSwift.StateType {
    enum ViewState {
        case show
        case loading
        case update
        case error(error: Error)
        case idle
    }
    var viewState: ViewState = .idle
    
    var heroId: String = ""
    var color: ColorEntity = ColorEntity()
    var monochromeColors: ColorsEntity = ColorsEntity()
}
