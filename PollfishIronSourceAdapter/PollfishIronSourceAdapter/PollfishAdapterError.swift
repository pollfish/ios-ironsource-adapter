//
//  PollfishAdapterError.swift
//  PollfishIronSourceAdapter
//
//  Created by Fotis Mitropoulos on 1/4/22.
//

import Foundation

enum PollfishAdapterError {
    
    var code: Int {
        get {
            switch self {
            case .panelAlreadyOpen(_, let code),
                    .missingApiKey(_, let code),
                    .notLoaded(_, let code),
                    .notAvailable(_, let code),
                    .notEligible(_, let code):
                return code
            }
        }
    }
    
    var message: String {
        get {
            switch self {
            case .panelAlreadyOpen(let message, _),
                    .missingApiKey(let message, _),
                    .notLoaded(let message, _),
                    .notAvailable(let message, _),
                    .notEligible(let message, _):
                return message
            }
        }
    }
    
    case panelAlreadyOpen(String, Int)
    case missingApiKey(String, Int)
    case notLoaded(String, Int)
    case notAvailable(String, Int)
    case notEligible(String, Int)
}
