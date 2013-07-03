//
//  GuoHeAdAdapter_Domob.m
//  TestGuoHeAd1
//
//  Created by Daniel on 11-5-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_Domob.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_Domob

@synthesize doMobView = _doMobView;

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
    CGSize doMobsize;
    if (adsize.width==320&&adsize.height==50) {
        doMobsize = DOMOB_AD_SIZE_320x50;
    }else if (adsize.width==300&&adsize.height==250) {
        doMobsize = DOMOB_AD_SIZE_300x250;
    }else if (adsize.width==468&&adsize.height==60) {
        doMobsize = DOMOB_AD_SIZE_488x80;
    }else if (adsize.width==728&&adsize.height==90) {
        doMobsize = DOMOB_AD_SIZE_728x90;
    }
    
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>1) {
        self.doMobView = [[DMAdView alloc] initWithPublisherId:[keyArray objectAtIndex:0] size:doMobsize autorefresh:NO];
        self.doMobView.frame = CGRectMake(0, 0, adsize.width, adsize.height);
        self.doMobView.delegate = self;
        self.doMobView.rootViewController = [self.adView.delegate viewControllerForPresentingModalView];
        [_doMobView loadAd];

        //---------- begin: add codes for non-listener ad network track click data
        if (_nonListenerGR==nil) {
            _nonListenerGR = [[UITapGestureRecognizer alloc] initWithTarget:self.adView action:@selector(nonListenerNetworkAdClicked)];
        }        
        _nonListenerGR.delegate = self;
        [_nonListenerGR setNumberOfTapsRequired:1];
        [_nonListenerGR setNumberOfTouchesRequired:1];
        [_nonListenerGR setCancelsTouchesInView:NO];
        [self.doMobView addGestureRecognizer:_nonListenerGR];
        //----------- end
    }
    else{
        NSLog(@"App Domob key null..");
    }
}

- (void)dealloc {
    [_doMobView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
    _doMobView.delegate = nil;
    _doMobView.rootViewController = nil;
    [_doMobView release];
	[super dealloc];
}

- (NSString *)domobKeywords{
   
	return nil;
}

- (void)dmAdViewSuccessToLoadAd:(DMAdView *)adView
{
    [self.adView setAdContentView:_doMobView];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void)dmAdViewFailToLoadAd:(DMAdView *)adView withError:(NSError *)error
{
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (void)dmWillPresentModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"dmWillPresentModalViewFromAd");
}

- (void)dmDidDismissModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"dmDidDismissModalViewFromAd");
}

- (void)dmApplicationWillEnterBackgroundFromAd:(DMAdView *)adView
{
    NSLog(@"dmApplicationWillEnterBackgroundFromAd");
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
