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
        
        // Action craetor
        static func fetchColorsActionCreator() -> Store<AppState>.ActionCreator {
            return { (state, store) in
                store.dispatch(HomeState.Action.requestStart)
                
                let provider = MoyaAPIFactory.shared
                provider.request(.schemeTest(TestParams())) { result in
                    if let error = result.error {
                        store.dispatch(HomeState.Action.requestError(error: error))
                    }
                    if let data = result.value?.data {
                        do {
                            let entity = try JSONDecoder().decode(ColorsEntity.self, from: data)
                            store.dispatch(HomeState.Action.requestSuccess(response: entity))
                        } catch let error {
                            store.dispatch(HomeState.Action.requestError(error: error))
                        }
                    }
                }
                return nil
            }
        }
    }
}
