//
//  GlobalState.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/30.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

struct GlobalState: ReSwift.StateType {
    public enum ApplicationState {
        case willResignActive
        case didEnterBackground
        case willEnterForeground
        case didBecomeActive
        case willTerminate
    }
    var appState: ApplicationState = .willTerminate
}
