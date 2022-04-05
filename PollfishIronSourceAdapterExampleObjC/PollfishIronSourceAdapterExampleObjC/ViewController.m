//
//  ViewController.m
//  PollfishIronSourceAdapterExampleObjC
//
//  Created by Fotis Mitropoulos on 31/3/22.
//

#import "ViewController.h"

// Place your app key here
#define APPKEY @"APP_KEY"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *showRewardedAdBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        [self setupIronSource];
    }];
}

- (void)setupIronSource {
    [ISIntegrationHelper validateIntegration];
    [IronSource initWithAppKey:APPKEY];
    [IronSource setRewardedVideoDelegate:self];
}

- (IBAction)showRewardedAd:(id)sender {
    [IronSource showRewardedVideoWithViewController:self];
}

- (void)rewardedVideoHasChangedAvailability:(BOOL)available {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.showRewardedAdBtn setEnabled:available];
    });
}

- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo {
    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, placementInfo.rewardAmount, placementInfo.rewardName);
}

- (void)rewardedVideoDidFailToShowWithError:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)rewardedVideoDidOpen {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)rewardedVideoDidClose {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)rewardedVideoDidStart {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)rewardedVideoDidEnd {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didClickRewardedVideo:(ISPlacementInfo *)placementInfo {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
