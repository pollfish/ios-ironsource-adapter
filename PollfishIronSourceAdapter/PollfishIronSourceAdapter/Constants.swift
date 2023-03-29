//
//  PollfishConstants.swift
//  PollfishIronSourceAdapter
//
//  Created by Fotis Mitropoulos on 30/3/22.
//

import Foundation

struct Constants {
    static let version = "6.4.1.0"
    static let pollfishVersion = "6.4.1"
    static let networkName = "pollfish"
    
    struct AdDataKey {
        static let apiKey = "api_key"
        static let requestUUID = "request_uuid"
        static let releaseMode = "release_mode"
        static let offerwallMode = "offerwall_mode"
    }
    
    struct Error {
        static let panelAlreadyOpen = PollfishAdapterError.panelAlreadyOpen("Pollfish survey panel is already visible", 2)
        static let missingApiKey = PollfishAdapterError.missingApiKey("api_key parameter is missing from your Pollfish Network configuration", 3)
        static let notLoaded = PollfishAdapterError.notLoaded("Pollfish has not loaded", 4)
        static let notAvailable = PollfishAdapterError.notAvailable("Pollfish is not available", 5)
        static let notEligible = PollfishAdapterError.notEligible("User is not eligible for Pollfish surveys", 6)
    }
}
