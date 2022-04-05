//
//  ISPollfishCustomAdapter.swift
//  PollfishIronSourceAdapter
//
//  Created by Fotis Mitropoulos on 23/3/22.
//

import Foundation
import Pollfish
import IronSource

@objc(ISPollfishCustomAdapter)
public class ISPollfishCustomAdapter : ISBaseNetworkAdapter {
    
    
    public override func `init`(_ adData: ISAdData, delegate: ISNetworkInitializationDelegate) {
        delegate.onInitDidSucceed()
        return
    }
    
    public override func networkSDKVersion() -> String {
        return Constants.pollfishVersion
    }
    
    public override func adapterVersion() -> String {
        return Constants.version
    }
    
}
