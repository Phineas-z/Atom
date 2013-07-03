//
//  AdWhirlAdapterGuohe.m
//  AdwirlDemo
//
//  Created by luyuanshuo on 13-7-3.
//  Copyright (c) 2013年 luyuanshuo. All rights reserved.
//

#import "AdWhirlAdapterGuohe.h"
#import "AdWhirlView.h"
#import "AdWhirlConfig.h"
#import "AdWhirlAdNetworkConfig.h"
#import "AdWhirlAdNetworkAdapter+Helpers.h"
#import "AdWhirlAdNetworkRegistry.h"
#import "GHAdView.h"

@interface AdWhirlAdapterGuohe()<GHAdViewDelegate>
@end

@implementation AdWhirlAdapterGuohe

+(AdWhirlAdNetworkType)networkType{
    return AdWhirlAdNetworkTypeJumpTap;
}

+(void)load{
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:[self class]];
}

-(void)getAd{
    GHAdView* ghAdView = [[[GHAdView alloc] initWithAdUnitId:[self guoheId] size:CGSizeMake(300., 250.)] autorelease];
    ghAdView.delegate = self;
    [ghAdView loadAd];
    
    //Set actual adview as adNetworkView
    self.adNetworkView = ghAdView;
}

- (NSString *)guoheId{
    return networkConfig.credentials[@"PublisherID"];
}

-(void)stopBeingDelegate{
    GHAdView* ghAdView = (GHAdView*)self.adNetworkView;
    
    [ghAdView stopAdRequest];
    ghAdView.delegate = nil;
    self.adNetworkView = nil;
}

#pragma mark - GHAdViewDelegate
- (UIViewController *)viewControllerForPresentingModalView{
    return [adWhirlView.delegate viewControllerForPresentingModalView];
}

- (void)adViewDidLoadAd:(GHAdView *)view{
    [adWhirlView adapter:self didReceiveAdView:view];
}

- (void)adViewDidFailToLoadAd:(GHAdView *)view{
    [adWhirlView adapter:self didFailAd:nil];
}

@end
