//
//  ViewController.swift
//  PollfishIronSourceAdapterExampleSwift
//
//  Created by Fotis Mitropoulos on 31/3/22.
//

import UIKit
import ObjectiveC.runtime
import AppTrackingTransparency

class ViewController: UIViewController, ISRewardedVideoDelegate {
    
    private let appKey = "APP_KEY"
    @IBOutlet weak var showRewardedAdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ATTrackingManager.requestTrackingAuthorization { status in
            self.setupIronSource()
        }
    }

    private func setupIronSource() {
        ISIntegrationHelper.validateIntegration()
        
        IronSource.setRewardedVideoDelegate(self)
        IronSource.initWithAppKey(appKey)
    }
    
    @IBAction func showRewardedAd(_ sender: Any) {
        IronSource.showRewardedVideo(with: self)
    }
    
    public func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
        print(#function + " " + String(describing: placementInfo.self))
    }
    
    
    func rewardedVideoDidFailToShowWithError(_ error: Error!) {
        print(#function + " " + String(describing: error.self))
    }
    
    func rewardedVideoDidOpen() {
        print(#function)
    }
    
    func rewardedVideoDidClose() {
        print(#function)
    }
    
    func rewardedVideoDidEnd() {
        print(#function)
    }
    
    func rewardedVideoDidStart() {
        print(#function)
    }
    
    func rewardedVideoHasChangedAvailability(_ available: Bool) {
        showRewardedAdButton.isEnabled = available
        print(#function + " isAvailable: \(available)")
    }
    
    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
        print(#function)
    }

}

