//
//  HomeState.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

struct HomeState: ReSwift.StateType {
    var requestHex: String?
    
    enum RequestState {
        case initial
        case loading
        case success
        case error
    }
    var request: RequestState = .initial
    var colorList: ColorsEntity = ColorsEntity()
}
