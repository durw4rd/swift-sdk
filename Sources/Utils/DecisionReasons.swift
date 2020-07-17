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

protocol Reasonable {
    var reason: String { get }
}

class DecisionReasons {
    var errors: [Reasonable]
    var logs: [Reasonable]
    
    init() {
        errors = []
        logs = []
    }
    
    func addError(_ error: Reasonable) {
        errors.append(error)
    }
    
    func addInfo(_ info: Reasonable) {
        logs.append(info)
    }
    
    var reasonsRequired: [String] {
        return errors.map{ $0.reason }
    }
    
    var reasonsOptional: [String] {
        return logs.map{ $0.reason }
    }
    
    func getReasonsToReport(options: [OptimizelyDecideOption]) -> [String] {
        return reasonsRequired + (options.contains(.includeReasons) ? reasonsOptional : [])
    }
}