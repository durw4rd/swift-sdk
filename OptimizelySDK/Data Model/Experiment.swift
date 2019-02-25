/****************************************************************************
 * Copyright 2018, Optimizely, Inc. and contributors                        *
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

struct Experiment : Codable
{
    
    enum Status: String, Codable {
        case Running
        case Launched
        case Paused
        case Not_started = "Not started"
        case Archived
    }
    
    var id:String = ""
    var key:String = ""
    
    var status:Status = Status.Not_started
    
    var layerId:String = ""
    var trafficAllocation:[TrafficAllocation] = []
    var audienceIds:[String] = []
    var audienceConditions:ConditionHolder?
    var variations:[Variation] = []
    var forcedVariations:Dictionary<String,String>? = Dictionary<String,String>()
}