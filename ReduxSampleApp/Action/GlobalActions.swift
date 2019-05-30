//
//  GlobalActions.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/30.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

extension GlobalState {
    enum Action: ReSwift.Action {
        case changeApplicationState(appState: ApplicationState)
    }
}
