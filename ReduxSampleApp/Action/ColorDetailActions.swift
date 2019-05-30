//
//  ColorDetailActions.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import ReSwift

extension ColorDetailState {
    enum Action: ReSwift.Action {
        case setColor(color: ColorEntity, heroId: String)
    }
}
