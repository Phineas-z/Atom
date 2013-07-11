//
//  GuoHeAdAdapter_Admob.m
//  GuoHeSDKTest
//
//  Created by Daniel on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_Admob.h"
#import "GHAdView.h"
#import "CJSONDeserializer.h"

@implementation GuoHeAdAdapter_Admob
@synthesize adBannerView = _adBannerView;

- (void)dealloc
{
	_adBannerView.delegate = nil;
	[_adBannerView release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|"];
	if ([keyArray count]>0) {
        GADAdSize theSize = kGADAdSizeBanner;
        if (adsize.width==320&&adsize.height==50) {
            theSize = kGADAdSizeBanner;
        }else if (adsize.width==300&&adsize.height==250) {
            theSize = kGADAdSizeMediumRectangle;
        }else if (adsize.width==468&&adsize.height==60) {
            theSize = kGADAdSizeFullBanner;
        }else if (adsize.width==728&&adsize.height==90) {
            theSize = kGADAdSizeLeaderboard;
        }else {
            theSize = kGADAdSizeInvalid;
        }
        
		self.adBannerView = [[GADBannerView alloc] initWithAdSize:theSize];
		_adBannerView.delegate = self;
		_adBannerView.adUnitID = [keyArray objectAtIndex:0];
        _adBannerView.rootViewController = [self.adView.delegate viewControllerForPresentingModalView];
        GADRequest *request = [GADRequest request];
        [_adBannerView loadRequest:request];
        
	}
    else{
        _adBannerView.adUnitID = nil;
        GHLogWarn(@"App Admob key null..");
    }
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
	[self.adView setAdContentView:bannerView];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"admob Error:%@", [error localizedDescription]);
	[self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    [self.adView userActionWillBeginForAdapter:self];
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
    [self.adView userActionDidEndForAdapter:self];
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
    [self.adView nonListenerNetworkAdClicked];
}


@end
