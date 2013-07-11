//
//  AdWhirlAdapterDomob.m
//  AdwirlDemo
//
//  Created by luyuanshuo on 13-7-11.
//  Copyright (c) 2013年 luyuanshuo. All rights reserved.
//

#import "AdWhirlAdapterDomob.h"
#import "AdWhirlView.h"
#import "AdWhirlConfig.h"
#import "AdWhirlAdNetworkConfig.h"
#import "AdWhirlAdNetworkAdapter+Helpers.h"
#import "AdWhirlAdNetworkRegistry.h"
#import "DMAdView.h"

#define AD_SIZE CGSizeMake(300., 250.)

@interface AdWhirlAdapterDomob()<DMAdViewDelegate>
@end

@implementation AdWhirlAdapterDomob

+(AdWhirlAdNetworkType)networkType{
    return AdWhirlAdNetworkTypeDomob;
}

+(void)load{
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:[self class]];
}

-(void)getAd{
    DMAdView* dmAdView = [[[DMAdView alloc] initWithPublisherId:networkConfig.pubId size:AD_SIZE autorefresh:NO] autorelease];
    dmAdView.frame = CGRectMake(0, 0, AD_SIZE.width, AD_SIZE.height);
    dmAdView.delegate = self;
    dmAdView.rootViewController = [adWhirlView.delegate viewControllerForPresentingModalView];
    [dmAdView loadAd];
    
    self.adNetworkView = dmAdView;    
}

-(void)stopBeingDelegate{
    DMAdView* dmAdView = (DMAdView*)self.adNetworkView;
    
    dmAdView.delegate = nil;
    self.adNetworkView = nil;
}

#pragma mark - DMAdViewDelegate

- (void)dmAdViewSuccessToLoadAd:(DMAdView *)adView{
    [adWhirlView adapter:self didReceiveAdView:adView];
}

- (void)dmAdViewFailToLoadAd:(DMAdView *)adView withError:(NSError *)error{
    [adWhirlView adapter:self didFailAd:error];
}

@end
