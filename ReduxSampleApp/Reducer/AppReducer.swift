//
//  AppReducer.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/29.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

func appReducer(action: ReSwift.Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    state.homeState = HomeState.reducer(action: action, state: state.homeState)
    // state.colorDetailState = ?
    return state
}
