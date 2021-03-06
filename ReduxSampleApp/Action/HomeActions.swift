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
        case createHex(hexString: String)
        case requestStart
        case requestSuccess(response: ColorsEntity)
        case requestError(error: Error)
        case refresh(hexString: String)
        case updateFavorite(new: ColorsEntity)
        
        // Action craetor
        static func generateRandomHex() -> ReSwift.Store<AppState>.ActionCreator {
            return { (state, store) in
                guard let requestHex = state.homeState.requestHex else {
                    return createHex(hexString: String(Int.random(in: 0 ..< 16777215), radix: 16))
                }
                return createHex(hexString: requestHex)
            }
        }
        
        static func fetchColorsActionCreator() -> ReSwift.Store<AppState>.ActionCreator {
            return { (state, store) in
                guard state.homeState.request != HomeState.RequestState.success else { return nil }
                
                MoyaAPIFactory.shared
                    .request(.getColors(with: GetColorsParams(hex: state.homeState.requestHex!, count: 30, mode: "analogic"))) { result in
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
                return requestStart
            }
        }
        
        static func refreshHexActionCreator() -> ReSwift.Store<AppState>.ActionCreator {
            return { (state, store) in
                return refresh(hexString: String(Int.random(in: 0 ..< 16777215), radix: 16))
            }
        }
        
        static func updateFavoriteActionCreator() -> ReSwift.Store<AppState>.ActionCreator {
            return { (state, store) in
                guard let index = state.homeState.colorList.colors
                    .firstIndex(where: { $0.hex.value == state.colorDetailState.color.hex.value }) else { return nil }
                let colors = state.homeState.colorList
                colors.colors[index].isFavorite.toggle()
                return updateFavorite(new: colors)
            }
        }
    }
}
