//
//  AppDelegate.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit
import ReSwift

let appStore = Store<AppState>(reducer: appReducer, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        let rootViewController = UINavigationController(rootViewController: vc)
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        dispatch(GlobalState.Action.changeApplicationState(appState: .willResignActive))
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        dispatch(GlobalState.Action.changeApplicationState(appState: .didEnterBackground))
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        dispatch(GlobalState.Action.changeApplicationState(appState: .willEnterForeground))
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        dispatch(GlobalState.Action.changeApplicationState(appState: .didBecomeActive))
    }

    func applicationWillTerminate(_ application: UIApplication) {
        dispatch(GlobalState.Action.changeApplicationState(appState: .willTerminate))
    }
    
    private func dispatch(_ action: ReSwift.Action) {
        appStore.dispatch(action)
    }
}
