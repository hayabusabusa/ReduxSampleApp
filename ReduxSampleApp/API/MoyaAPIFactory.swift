//
//  MoyaAPIFactory.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/29.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import Foundation
import Moya

final class MoyaAPIFactory {
    static let shared: MoyaProvider<MoyaApi> = MoyaAPIFactory.create()
    
    static func create() -> MoyaProvider<MoyaApi> {
        let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true)]
        let provider = MoyaProvider<MoyaApi>(plugins: plugins)
        return provider
    }
}
