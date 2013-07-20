//
//  AdWhirlAdapterMobisage.m
//  AdwirlDemo
//
//  Created by luyuanshuo on 13-7-16.
//  Copyright (c) 2013年 luyuanshuo. All rights reserved.
//

#import "AdWhirlAdapterMobisage.h"
#import "AdWhirlView.h"
#import "AdWhirlConfig.h"
#import "AdWhirlAdNetworkConfig.h"
#import "AdWhirlAdNetworkAdapter+Helpers.h"
#import "AdWhirlAdNetworkRegistry.h"
#import "MobiSageSDK.h"

@interface AdWhirlAdapterMobisage()<MobiSageAdViewDelegate>
@end

@implementation AdWhirlAdapterMobisage

+(AdWhirlAdNetworkType)networkType{
    return AdWhirlAdNetworkTypeMobisage;
}

+(void)load{
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:[self class]];
}

-(void)getAd{    
    //初始化ID
    [[MobiSageManager getInstance] setPublisherID:networkConfig.pubId];
    
    MobiSageAdPoster* adBanner = [[MobiSageAdPoster alloc] initWithAdSize:Poster_320X320 withDelegate:self];//Size用Poster枚举
    //请求广告
    [adBanner startRequestAD];
        
    self.adNetworkView = adBanner;
    
    [adBanner release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adViewReceived:) name:MobiSageAdView_Start_Show_AD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adViewFailed:) name:MobiSageAction_Error object:nil];
}

-(void)stopBeingDelegate{
    MobiSageAdPoster* adBanner = (MobiSageAdPoster*)self.adNetworkView;
    adBanner.delegate = nil;
    
    self.adNetworkView = nil;
}

#pragma mark - MobiSageAdViewDelegate
-(UIViewController *)viewControllerToPresent{
    return [adWhirlView.delegate viewControllerForPresentingModalView];
}

#pragma mark - Ad Events
-(void)adViewReceived:(NSNotification*)notification{
    [adWhirlView adapter:self didReceiveAdView:self.adNetworkView];
}

-(void)adViewFailed:(NSNotification*)notification{
    [adWhirlView adapter:self didFailAd:nil];
}
@end
