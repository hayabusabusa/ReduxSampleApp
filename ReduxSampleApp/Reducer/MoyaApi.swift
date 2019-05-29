//
//  MoyaApi.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/29.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import Moya

enum MoyaApi {
    case schemeTest(TestParams)
    case getColors(GetColorsParams)
}

extension MoyaApi: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: Configuration.endPoint) else {
            fatalError("API Error: end point URL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .schemeTest:
            return "/scheme"
        case .getColors:
            return "/scheme"
        }
    }
    
    var method: Method {
        switch self {
        case .schemeTest, .getColors:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .schemeTest(let params):
            let parameter = [
                "hex": params.hex,
                "count": params.count,
                "mode": params.mode
            ] as [String: Any]
            return parameter
        case .getColors(let params):
            let parameters = [
                "hex": params.hex,
                "count": params.count,
                "mode": params.mode
            ] as [String: Any]
            return parameters
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .schemeTest, .getColors:
            return Moya.URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .schemeTest, .getColors:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
