//
//  ColorDetailReducer.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/30.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

extension ColorDetailState {
    public static func reducer(action: ReSwift.Action, state: ColorDetailState?) -> ColorDetailState {
        var state = state ?? ColorDetailState()
        guard let action = action as? ColorDetailState.Action else { return state }
        
        switch action {
        case .setColor(let color, let heroId):
            state.color = color
            state.heroId = heroId
        }
        return state
    }
}
