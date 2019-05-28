//
//  HomeActions.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

extension HomeState {
    enum Action: ReSwift.Action {
        case requestStart
        case requestSuccess(response: ColorsEntity)
        case requestError(error: Error)
    }
}


func fetchColors(state: State, store: Store<State>) -> Action? {
    return nil
}
