//
//  AppState.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

struct AppState: ReSwift.StateType {
    var globalState: GlobalState = GlobalState()
    var homeState: HomeState = HomeState()
    var colorDetailState: ColorDetailState = ColorDetailState()
}
