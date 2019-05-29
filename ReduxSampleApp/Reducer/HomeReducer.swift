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
        case .requestStart:
            state.isLoading = true
        case .requestSuccess(let response):
            state.isLoading = false
            state.colorList = response
        case .requestError(let error):
            state.isLoading = false
            print(error.localizedDescription)
        }
        return state
    }
}
