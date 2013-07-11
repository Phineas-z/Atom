//
//  GuoHeAdAdapter_MobWIN.m
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 26/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_MobWIN.h"
#import "GHAdView.h"
#import "MobWinBannerView.h"

@implementation GuoHeAdAdapter_MobWIN
@synthesize adBannerView = _adBannerView;

- (void)dealloc
{
	[_adBannerView  release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
    MobWinBannerSizeIdentifier adSizeIndetifier = MobWINBannerSizeIdentifier320x50;

    if (adsize.width==320&&adsize.height==50) {
        adSizeIndetifier = MobWINBannerSizeIdentifier320x50;
    }else if (adsize.width==300&&adsize.height==250) {
        adSizeIndetifier = MobWINBannerSizeIdentifier300x250;
    }else if (adsize.width==468&&adsize.height==60) {
        adSizeIndetifier = MobWINBannerSizeIdentifier468x60;
    }else if (adsize.width==728&&adsize.height==90) {
        adSizeIndetifier = MobWINBannerSizeIdentifier728x90;
    }else{
        GHLogWarn(@"App MobWIN size wrong..");
        adSizeIndetifier = MobWINBannerSizeIdentifierUnknow;
    }
    
    NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>0) {
        MobWinBannerView *adBanner = [[MobWinBannerView alloc] initMobWinBannerSizeIdentifier:adSizeIndetifier keyByMobWIN:@"son1128zoz"];
        adBanner.rootViewController = [self.adView.delegate viewControllerForPresentingModalView];
        self.adBannerView = adBanner;
        [adBanner release];
        
        [self.adBannerView setAdUnitID:[keyArray objectAtIndex:0]];
        _adBannerView.delegate = self;
        [_adBannerView startRequest];
        
    }
    else{
        NSLog(@"App MobWIN key null..");
    }
}

- (void)adapterWillDealloc
{
    [_adBannerView stopRequest];
}

- (void)bannerViewDidReceived
{
    [self.adView setAdContentView:_adBannerView];
    [self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void)bannerViewFailToReceived
{
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (void)bannerViewDidClicked
{
    [self.adView userActionWillBeginForAdapter:self];
}

- (void)bannerViewDidDismissScreen
{
    [self.adView userActionDidEndForAdapter:self];
}

@end
