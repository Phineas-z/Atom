//
//  AdWhirlAdapterVpon.m
//  AdwirlDemo
//
//  Created by luyuanshuo on 13-7-16.
//  Copyright (c) 2013年 luyuanshuo. All rights reserved.
//

#import "AdWhirlAdapterVpon.h"
#import "AdWhirlView.h"
#import "AdWhirlConfig.h"
#import "AdWhirlAdNetworkConfig.h"
#import "AdWhirlAdNetworkAdapter+Helpers.h"
#import "AdWhirlAdNetworkRegistry.h"
#import "VponBanner.h"
#import "AppDelegate.h"

@interface AdWhirlAdapterVpon()<VponBannerDelegate>
@property (nonatomic, retain) VponBanner* vponAd;
@end

@implementation AdWhirlAdapterVpon

+(AdWhirlAdNetworkType)networkType{
    return AdWhirlAdNetworkTypeVpon;//
}

+(void)load{
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:[self class]];
}

-(void)getAd{
    self.vponAd = [[[VponBanner alloc] initWithAdSize:VponAdSizeMediumRectangle origin:CGPointZero] autorelease];
    self.vponAd.strBannerId = networkConfig.pubId;   // 填入您的BannerId
    self.vponAd.delegate = self;
    self.vponAd.platform = TW;
    [self.vponAd setAdAutoRefresh:YES];
    [self.vponAd setRootViewController:[adWhirlView.delegate viewControllerForPresentingModalView]];
    
    [self.vponAd startGetAd:[self getTestIdentifiers]];
    
    self.adNetworkView = [self.vponAd getVponAdView];
}

-(void)stopBeingDelegate{
    self.vponAd.delegate = nil;
    self.vponAd = nil;
    
    self.adNetworkView = nil;
}

-(NSArray*)licenseKey{
    if (networkConfig.pubId && ![networkConfig.pubId isEqualToString:@""]) {
        return @[networkConfig.pubId];
    }else{
        return nil;
    }
}

#pragma mark - VponAdOnDelegate

-(void)onVponAdReceived:(UIView *)bannerView{
    [adWhirlView adapter:self didReceiveAdView:bannerView];
}

-(void)onVponAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error{
    [adWhirlView adapter:self didFailAd:error];
}

-(NSArray*)getTestIdentifiers
{
    return @[@"ec56bc0f14e6b5bb080ab547d811cd62"];
}

//-(NSArray*)getTestIdentifiers
//{
//    return [NSArray arrayWithObjects:
//            // add your test UUID
//            nil];
//}

@end
