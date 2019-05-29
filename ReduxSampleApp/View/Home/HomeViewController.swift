//
//  HomeViewController.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit
import ReSwift

final class HomeViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = HomeState
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appStore.subscribe(self) { subscription in
            subscription.select { state in state.homeState }
        }
        appStore.dispatch(HomeState.Action.fetchColorsActionCreator())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appStore.unsubscribe(self)
    }
    
    func newState(state: HomeState) {
        state.colorList.colors.forEach({ (it) in print(it.name.value) })
    }
}
