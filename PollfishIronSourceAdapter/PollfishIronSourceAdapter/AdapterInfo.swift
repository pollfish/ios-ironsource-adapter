//
//  AdapterInfo.swift
//  PollfishIronSourceAdapter
//
//  Created by Fotis Mitropoulos on 31/3/22.
//

import Foundation
import IronSource

class AdapterInfo : CustomStringConvertible {
    let apiKey: String
    let releaseMode: Bool?
    let requestUUID: String?
    let offerwallMode: Bool?
    
    var description: String {
        get {
            "{api_key: \(apiKey), release_mode: \(releaseMode ?? false), offerwall_mode: \(offerwallMode ?? false), request_uuid: \(requestUUID ?? "null")}"
        }
    }
    
    init?(_ adData: ISAdData) {
        guard let apiKey = adData.getString(Constants.AdDataKey.apiKey) else {
            return nil
        }
        
        self.apiKey = apiKey
        
        if let releaseMode = adData.getString(Constants.AdDataKey.releaseMode) {
            self.releaseMode = NSString(string: releaseMode).boolValue
        } else {
            self.releaseMode = nil
        }
        
        if let requestUUID = adData.getString(Constants.AdDataKey.requestUUID), requestUUID != "null" {
            self.requestUUID = requestUUID
        } else {
            self.requestUUID = nil
        }
        
        if let offerwallMode = adData.getString(Constants.AdDataKey.offerwallMode) {
            self.offerwallMode = NSString(string: offerwallMode).boolValue
        } else {
            self.offerwallMode = nil
        }
        
        if (releaseMode != true) {
            print("Initializing Pollfish with the following params: \(description)")
        }
    }
    
}
