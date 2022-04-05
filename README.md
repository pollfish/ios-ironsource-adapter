# Pollfish iOS IronSource Mediation Adapter

IronSource Mediation Adapter for iOS apps looking to load and show Rewarded Surveys from Pollfish in the same waterfall with other Rewarded Ads.

> **Note:** A detailed step by step guide is provided on how to integrate can be found [here](https://www.pollfish.com/docs/ios-ironsource-adapter)

<br/>

## Step 1: Add Pollfish IronSource Adapter to your project

### **Manually import PollfishIronSourceAdapter**

Download the following frameworks

* [Pollfish SDK](https://www.pollfish.com/docs/ios)
* [IronSource SDK](https://developers.is.com/ironsource-mobile/ios/ios-sdk)
* [PollfishIronSourceAdapter](https://pollfish.com/docs/ios-ironsource-adapter)

and add them in your App's target dependecies 

1. Navigate to your project
2. Select your App's target and go to the **General** tab section **Frameworks, Libraries and Embedded Content**
3. Add all three dependent framewokrs one by one by pressing the + button -> Add other and selecting the appropriate framework

Add the following frameworks (if you don’t already have them) in your project

- AdSupport.framework  
- CoreTelephony.framework
- SystemConfiguration.framework 
- WebKit.framework (added in Pollfish v4.4.0)

**OR**

### **Retrieve Pollfish IronSource Adapter through CocoaPods**

Add a Podfile with PollfishIronSourceAdapter pod reference:

```ruby
pod 'PollfishIronSourceAdapter'
```

You can find the latest PollfishIronSourceAdapter version on CocoaPods [here](https://cocoapods.org/pods/PollfishIronSourceAdapter)

Run pod install on the command line to install PollfishIronSourceAdapter pod.

<br/>

## Step 2: Import `IronSourceSDK`

<span style="text-decoration:underline">Swift</span>

If you are using swift, you need to make sure your application is pointing to `IronSource.h` file to include the bridge you need.

Select your Project from the project navigator and navigate to Build Settings -> Swift Compiler - General and add the following path to the Objective-C Bridging Header setting.

The path to the bridging header varies according to the way the integration was done

<span style="text-decoration:underline">**CocoaPods**</span>

```
${PODS_ROOT}/IronSourceSDK/IronSource/IronSource.xcframework/ios-arm64_armv7/IronSource.framework/Versions/A/Headers/IronSource.h
```

<span style="text-decoration:underline">**Manual**</span>

```
Frameworks/IronSource.framework/Headers/IronSource.h
```

Once you’ve completed the above step, you can use Swift seamlessly within the ironSource SDK, without importing any additional Header Files.

<span style="text-decoration:underline">Objective C</span>

```objc
#import <IronSource/IronSource.h>
```

<br/>

## Step 3: Request for a RewardedAd

Initialize the IronSource SDK in your ViewController's `viewDidLoad` method, passing your App Key as provided by the IronSource dashboard.

<span style="text-decoration:underline">Swift</span>

```swift
override func viewDidLoad() {
    ...

    ISIntegrationHelper.validateIntegration()   
    IronSource.setRewardedVideoDelegate(self)
    IronSource.initWithAppKey("APP_KEY")
}
```

<span style="text-decoration:underline">Objective C</span>

```objc
- (void)viewDidLoad {
    ...
    
    [ISIntegrationHelper validateIntegration];
    [IronSource initWithAppKey:@"APP_KEY"];
    [IronSource setRewardedVideoDelegate:self];
}
```

<br/>

Comform to `ISRewardedVideoDelegate` so that you are notified when your ad is ready and of other ad-related events.

<span style="text-decoration:underline">Swift</span>

```swift
class ViewController: UIViewController, ISRewardedVideoDelegate
```

<span style="text-decoration:underline">Objective C</span>

```objc
@interface ViewController ()<MARewardedAdDelegate>
```

<br/>

When the Rewarded Ad is ready, present the ad by invoking `IronSource.showRewardedVideo`.

<span style="text-decoration:underline">Swift</span>

```swift
IronSource.showRewardedVideo(with: self)
```

<span style="text-decoration:underline">Objective C</span>

```objc
[IronSource showRewardedVideoWithViewController:self];
```

<br/>

You can view a short example on how to intergate rewarded ads below

<span style="text-decoration:underline">Swift</span>

```swift
import ObjectiveC.runtime
import AppTrackingTransparency

class ViewController: UIViewController, ISRewardedVideoDelegate {

    ...

    @IBOutlet weak var showRewardedAdButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ATTrackingManager.requestTrackingAuthorization { status in
            self.createRewardedAd()
        }
    }

    private func createRewardedAd() {
        ISIntegrationHelper.validateIntegration()
        
        IronSource.setRewardedVideoDelegate(self)
        IronSource.initWithAppKey(appKey)
    }
    
    @IBAction func showRewardedAd(_ sender: Any) {
        IronSource.showRewardedVideo(with: self)
    }

    #pragma mark - ISRewardedVideoDelegate Protocol

    public func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {}
    
    func rewardedVideoDidFailToShowWithError(_ error: Error!) {}
    
    func rewardedVideoDidOpen() {}
    
    func rewardedVideoDidClose() {}
    
    func rewardedVideoDidEnd() {}
    
    func rewardedVideoDidStart() {}
    
    func rewardedVideoHasChangedAvailability(_ available: Bool) {
        showRewardedAdButton.isEnabled = available
    }
    
    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {}

}
```

<span style="text-decoration:underline">Objective C</span>

```objc
#import <IronSource/IronSource.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface ViewController()<ISRewardedVideoDelegate>
@property (weak, nonatomic) IBOutlet UIButton *showRewardedAdBtn;
@end

@implementation ViewController

...

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        [self createRewardedAd];
    }];
}

- (void)createRewardedAd
{
    [ISIntegrationHelper validateIntegration];
    [IronSource initWithAppKey:@"APP_KEY"];
    [IronSource setRewardedVideoDelegate:self];
}

- (IBAction)showRewardedAd:(id)sender {
    [IronSource showRewardedVideoWithViewController:self];
}

#pragma mark - ISRewardedVideoDelegate Protocol

- (void)rewardedVideoHasChangedAvailability:(BOOL)available {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.showRewardedAdBtn setEnabled:available];
    });
}

- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo {}

- (void)rewardedVideoDidFailToShowWithError:(NSError *)error {}

- (void)rewardedVideoDidOpen {}

- (void)rewardedVideoDidClose {}

- (void)rewardedVideoDidStart {}

- (void)rewardedVideoDidEnd {}

- (void)didClickRewardedVideo:(ISPlacementInfo *)placementInfo {}

@end
```

<br/>

## Step 4: Publish

If you everything worked fine during the previous steps, you should turn Pollfish to release mode and publish your app.

> **Note:** After you take your app live, you should request your account to get verified through Pollfish Dashboard in the App Settings area.

> **Note:** There is an option to show **Standalone Demographic Questions** needed for Pollfish to target users with surveys even when no actually surveys are available. Those surveys do not deliver any revenue to the publisher (but they can increase fill rate) and therefore if you do not want to show such surveys in the Waterfall you should visit your **App Settings** are and disable that option.

<br/>

# More info

You can read more info on how the Pollfish SDKs work or how to get started with IronSource at the following links:

[Pollfish iOS SDK](https://pollfish.com/docs/ios)

[IronSource iOS SDK](https://developers.is.com/ironsource-mobile/ios/ios-sdk)
