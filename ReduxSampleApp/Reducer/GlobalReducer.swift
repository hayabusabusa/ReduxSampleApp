//
//  GlobalReducer.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/30.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

extension GlobalState {
    public static func reducer(action: ReSwift.Action, state: GlobalState?) -> GlobalState {
        var state = state ?? GlobalState()
        guard let action = action as? GlobalState.Action else { return state }
        
        switch action {
        case .changeApplicationState(let appState):
            state.appState = appState
            switch appState {
            case .didEnterBackground:
                print("GlobalState: Application did enter background")
            case .willEnterForeground:
                print("GlobalState: Application will enter foreground")
            default:
                break
            }
        }
        return state
    }
}
