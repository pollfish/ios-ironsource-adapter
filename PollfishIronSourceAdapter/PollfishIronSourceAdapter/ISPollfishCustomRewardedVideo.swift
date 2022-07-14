//
//  ISPollfishCustomRewardedVideo.swift
//  PollfishIronSourceAdapter
//
//  Created by Fotis Mitropoulos on 30/3/22.
//

import Foundation
import Pollfish
import IronSource

@objc(ISPollfishCustomRewardedVideo)
public class ISPollfishCustomRewardedVideo : ISBaseRewardedVideo, PollfishDelegate {
    
    private weak var rewardedVideoAdDelegate: ISRewardedVideoAdDelegate? = nil
    
    public override func loadAd(with adData: ISAdData, delegate: ISRewardedVideoAdDelegate) {
        self.rewardedVideoAdDelegate = delegate
        
        if (Pollfish.isPollfishPanelOpen()) {
            self.rewardedVideoAdDelegate?.adDidFailToLoadWith(ISAdapterErrorType.internal,
                                                              errorCode: Constants.Error.panelAlreadyOpen.code,
                                                              errorMessage: Constants.Error.panelAlreadyOpen.message)
            return
        }
        
        guard let adapterInfo = AdapterInfo(adData) else {
            self.rewardedVideoAdDelegate?.adDidFailToLoadWith(ISAdapterErrorType.internal,
                                                              errorCode: Constants.Error.missingApiKey.code,
                                                              errorMessage: Constants.Error.missingApiKey.message)
            return
        }
        
        let params = PollfishParams(adapterInfo.apiKey)
            .rewardMode(true)
        
        if let releaseMode = adapterInfo.releaseMode {
            params.releaseMode(releaseMode)
        }
        
        if let requestUUID = adapterInfo.requestUUID {
            params.requestUUID(requestUUID)
        }
        
        params.platform(Platform.ironSource)
        
        Pollfish.initWith(params, delegate: self)
        
    }
    
    public override func showAd(with viewController: UIViewController, adData: ISAdData, delegate: ISRewardedVideoAdDelegate) {
        if (Pollfish.isPollfishPanelOpen()) {
            delegate.adDidFailToShowWithErrorCode(ISAdapterErrors.internal.rawValue, errorMessage: Constants.Error.panelAlreadyOpen.message)
        } else if (Pollfish.isPollfishPresent()) {
            Pollfish.show()
        } else {
            delegate.adDidFailToShowWithErrorCode(ISAdapterErrors.internal.rawValue, errorMessage: Constants.Error.notLoaded.message)
        }
    }
    
    public override func isAdAvailable(with adData: ISAdData) -> Bool {
        return Pollfish.isPollfishPresent()
    }
    
    public func pollfishOpened() {
        rewardedVideoAdDelegate?.adDidOpen()
    }
    
    public func pollfishClosed() {
        rewardedVideoAdDelegate?.adDidClose()
    }
    
    public func pollfishSurveyReceived(surveyInfo: SurveyInfo?) {
        rewardedVideoAdDelegate?.adDidLoad()
    }
    
    public func pollfishSurveyCompleted(surveyInfo: SurveyInfo) {
        rewardedVideoAdDelegate?.adDidEnd()
        rewardedVideoAdDelegate?.adRewarded()
    }
    
    public func pollfishSurveyNotAvailable() {
        rewardedVideoAdDelegate?.adDidFailToLoadWith(ISAdapterErrorType.noFill,
                                                     errorCode: Constants.Error.notAvailable.code,
                                                     errorMessage: Constants.Error.notAvailable.message)
    }
    
    public func pollfishUserNotEligible() {
        if (Pollfish.isPollfishPanelOpen()) {
            rewardedVideoAdDelegate?.adDidEnd()
        } else {
            rewardedVideoAdDelegate?.adDidFailToLoadWith(ISAdapterErrorType.noFill,
                                                         errorCode: Constants.Error.notEligible.code,
                                                         errorMessage: Constants.Error.notEligible.message)
        }
    }
    
    public func pollfishUserRejectedSurvey() {
        rewardedVideoAdDelegate?.adDidEnd()
    }
    
}
