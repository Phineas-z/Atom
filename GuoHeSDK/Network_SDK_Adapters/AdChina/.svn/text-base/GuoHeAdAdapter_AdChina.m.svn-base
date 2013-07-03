//
//  GuoHeAdAdapter_AdChina.m
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 23/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_AdChina.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_AdChina
@synthesize adBannerView = _adBannerView;

- (void)dealloc
{
    [_adBannerView release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>0) {
        [AdChinaLocationManager setLocationServiceEnabled:NO];
        self.adBannerView = [AdChinaBannerView requestAdWithAdSpaceId:[keyArray objectAtIndex:0] delegate:self adSize:adsize];
        
        [_adBannerView setViewControllerForBrowser:[self.adView.delegate viewControllerForPresentingModalView]];
        
        if (adsize.width==320&&adsize.height==50) {
            _adBannerView.frame = CGRectMake(0, 0, 320, 50);
        } else if (adsize.width==728&&adsize.height==90) {
            _adBannerView.frame = CGRectMake(0, 0, 728, 90);
        } 
        [_adBannerView setRefreshInterval:DisableRefresh];
        [_adBannerView setAccelerometerEnabled:NO];
        
	}
    else{
        GHLogWarn(@"App AdChina key null..");
    }
}

#pragma mark -
#pragma mark AdChina Banner Delegate

- (void)didGetBanner:(AdChinaBannerView *)adView {
    [self.adView setAdContentView:adView];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void)didFailToGetBanner:(AdChinaBannerView *)adView {
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (void)didEnterFullScreenMode{
    
}
- (void)didExitFullScreenMode{
    [self.adView userActionDidEndForAdapter:self];
}
- (void)didClickBanner:(AdChinaBannerView *)adView{
    [self.adView userActionWillBeginForAdapter:self];
}

@end
