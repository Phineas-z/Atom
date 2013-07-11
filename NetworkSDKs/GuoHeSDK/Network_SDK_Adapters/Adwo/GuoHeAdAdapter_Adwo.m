//
//  GuoHeAdapter_Adwo.m
//  GuoHeAdDev
//
//  Created by Daniel on 11-6-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_Adwo.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_Adwo
@synthesize adBannerView = _adBannerView;

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	
	if ([keyArray count]>1) {
        NSString *tempID = [keyArray objectAtIndex:0];
        NSString *strTest = [keyArray objectAtIndex:1];
        NSInteger isTest = 1;
        if ([strTest compare:@"true"]==NSOrderedSame) {
            isTest = 0;
        }
        
        SInt8 adBannerSize;
        if (adsize.width==320&&adsize.height==50) {
            adBannerSize = ADWO_ADSDK_AD_TYPE_NORMAL_BANNER;
        }else if (adsize.width==728&&adsize.height==90) {
            adBannerSize = ADWO_ADSDK_AD_TYPE_BANNER_SIZE_FOR_IPAD_720x110;
        }else{
            NSLog(@"App Adwo size wrong..");
            adBannerSize = -1;
        }
        
        AWAdView *awAdView = [[AWAdView alloc] initWithAdwoPid:tempID adTestMode:YES];
        if(awAdView == nil)
        {
            NSLog(@"Adwo ad view failed to create!");
            return;
        }
        self.adBannerView = awAdView;
        self.adBannerView.delegate = self;
        self.adBannerView.adRequestTimeIntervel = 300;

        // 设置渠道号
        [awAdView performSelector:@selector(setAGGChannel:) withObject:[NSNumber numberWithInteger:ADWOSDK_AGGREGATION_CHANNEL_GUOHEAD]];
        [self.adBannerView loadAd:adBannerSize];
        
        [awAdView release];
        
        //---------- begin: add codes for non-listener ad network track click data
        if (_nonListenerGR==nil) {
            _nonListenerGR = [[UITapGestureRecognizer alloc] initWithTarget:self.adView action:@selector(nonListenerNetworkAdClicked)];
        }        
        _nonListenerGR.delegate = self;
        [_nonListenerGR setNumberOfTapsRequired:1];
        [_nonListenerGR setNumberOfTouchesRequired:1];
        [_nonListenerGR setCancelsTouchesInView:NO];
        [_adBannerView addGestureRecognizer:_nonListenerGR];
        //----------- end

    }
    else{
        GHLogWarn(@"App Adwo key null..");
    }
}

- (void)dealloc {
    [_adBannerView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
//    [_adBannerView killTimer];
    _adBannerView.delegate = nil;
//    [_adBannerView removeFromSuperview];
    [_adBannerView release];
    _adBannerView = nil;
	[super dealloc];
}

#pragma mark implement AWDelegate method
- (void)adwoClickAdAction:(AWAdView*)adView
{
    NSLog(@"Did Click");
}

// 用于获取广告展示计数
- (void)adwoShowAdAction:(AWAdView*)adView
{
    NSLog(@"adwoShowAd");
}

- (void)adwoRequestAdAction:(AWAdView*)adView
{
    NSLog(@"adwoRequestAd");
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return [self.adView.delegate viewControllerForPresentingModalView];
}

- (void)adwoAdViewDidFailToLoadAd:(AWAdView*)adview
{
    NSLog(@"adwoAdViewDidFailToLoadAd");
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (void)adwoAdViewDidLoadAd:(AWAdView*)adview
{
    NSLog(@"adwoAdViewDidLoadAd");
    [self.adView setAdContentView:self.adBannerView];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}


///ad click gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return  YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return  YES;
}

@end
