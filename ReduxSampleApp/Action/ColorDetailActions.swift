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
        case requestStart
        case requestSuccess(response: ColorsEntity)
        case requestError(error: Error)
        
        static func fetchMonochromeColorsActionCreator() -> ReSwift.Store<AppState>.ActionCreator {
            return { (state, store) in
                MoyaAPIFactory.shared
                    .request(.getColorMonochrome(with: GetColorMonochromeParams(hex: state.colorDetailState.color.hex.clean, count: 5, mode: "monochrome"))) { result in
                    if let error = result.error {
                        store.dispatch(ColorDetailState.Action.requestError(error: error))
                    }
                    if let data = result.value?.data {
                        do {
                            let entity = try JSONDecoder().decode(ColorsEntity.self, from: data)
                            store.dispatch(ColorDetailState.Action.requestSuccess(response: entity))
                        } catch let error {
                            store.dispatch(ColorDetailState.Action.requestError(error: error))
                        }
                    }
                }
                return requestStart
            }
        }
    }
    
    
}
