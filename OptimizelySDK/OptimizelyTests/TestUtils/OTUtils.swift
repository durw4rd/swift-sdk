//
//  OTUtils.swift
//  OptimizelySwiftSDK
//
//  Created by Jae Kim on 2/11/19.
//  Copyright © 2019 Optimizely. All rights reserved.
//

import Foundation
import XCTest

class OTUtils {
    
    static func isEqualWithEncodeThenDecode<T: Codable & Equatable>(_ model: T) -> Bool {
        let jsonData = try! JSONEncoder().encode(model)
        let modelExp = try! JSONDecoder().decode(T.self, from: jsonData)
        return modelExp == model
    }
    
    static func getAttributeValueFromNative(_ value: Any) throws -> AttributeValue {
        // JSONEncoder does not support fragmented JSON format (string alone), so wrap in an array
        let json = [value]
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        let modelArray = try JSONDecoder().decode([AttributeValue].self, from: jsonData)
        return modelArray[0]
    }
    
    static func jsonDataFromNative(_ raw: Any) -> Data {
        return try! JSONSerialization.data(withJSONObject: raw, options: [])
    }
    
    static func jsonStringFromNative(_ raw: Any) -> String {
        return String(data: jsonDataFromNative(raw), encoding: .utf8)!
    }
    
    static func model<T: Codable>(from raw: Any) throws -> T {
        return try JSONDecoder().decode(T.self, from: jsonDataFromNative(raw))
    }
    
    static func loadJSONDatafile(_ filename: String) -> Data? {
        guard let filePath = Bundle(for: self).path(forResource: filename, ofType: "json") else {
            XCTAssert(false, "file not available: \(filename).json")
            return nil
        }
        
        do {
            let fileContents = try String(contentsOfFile: filePath)
            return fileContents.data(using: .utf8)
        } catch {
            XCTAssert(false, "cannot read file: \(filename).json")
            return nil
        }
    }
    
    static func createClearUserProfileService() -> DefaultUserProfileService {
        let ups = DefaultUserProfileService()
        ups.save(userProfile: DefaultUserProfileService.UserProfileData())
        return ups
    }

}
