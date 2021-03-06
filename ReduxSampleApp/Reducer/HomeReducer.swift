//
//  HomeReducer.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/29.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

extension HomeState {
    public static func reducer(action: ReSwift.Action, state: HomeState?) -> HomeState {
        var state = state ?? HomeState()
        
        guard let action = action as? HomeState.Action else { return state }
        switch action {
        case .createHex(let hex):
            state.requestHex = hex
        case .requestStart:
            state.request = .loading
        case .requestSuccess(let response):
            state.request = .success
            state.colorList = response
        case .requestError:
            state.request = .error
        case .refresh(let hex):
            state.requestHex = hex
            state.request = .initial
        case .updateFavorite(let colors):
            state.request = .success
            state.colorList = colors
        }
        return state
    }
}
