//
/****************************************************************************
* Copyright 2020, Optimizely, Inc. and contributors                        *
*                                                                          *
* Licensed under the Apache License, Version 2.0 (the "License");          *
* you may not use this file except in compliance with the License.         *
* You may obtain a copy of the License at                                  *
*                                                                          *
*    http://www.apache.org/licenses/LICENSE-2.0                            *
*                                                                          *
* Unless required by applicable law or agreed to in writing, software      *
* distributed under the License is distributed on an "AS IS" BASIS,        *
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
* See the License for the specific language governing permissions and      *
* limitations under the License.                                           *
***************************************************************************/
    

import Foundation

public struct OptimizelyUserContext {
    var userId: String?
    var attributes: [String: Any]
    var defaultOptions: [OptimizelyDecideOption]
    
    public init(userId: String?, attributes: [String: Any]? = nil) {
        self.userId = userId
        self.attributes = attributes ?? [:]
        self.defaultOptions = []
    }
    
    public mutating func setAttribute(key: String, value: Any) {
        attributes[key] = value
    }
    
    public mutating func setDefaultOptions(_ options: [OptimizelyDecideOption]) {
        defaultOptions.append(contentsOf: options)
    }
}

extension OptimizelyUserContext: Equatable {
    
    public static func ==(lhs: OptimizelyUserContext, rhs: OptimizelyUserContext) -> Bool {
        return lhs.userId == rhs.userId &&
            (lhs.attributes as NSDictionary).isEqual(to: rhs.attributes) &&
            Set(lhs.defaultOptions) == Set(rhs.defaultOptions)
    }
}