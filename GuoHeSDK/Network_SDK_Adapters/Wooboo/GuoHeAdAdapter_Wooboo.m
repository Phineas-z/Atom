//
//  GuoHeAdAdapter_Wooboo.m
//  GuoHeProiOSDev
//
//  Created by Wulin on 05/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_Wooboo.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_Wooboo

- (void)dealloc
{
    [_woobooView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
    [_woobooView release];
    [super dealloc];
}


- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize {
    NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>1) {
        NSString *tempID = [keyArray objectAtIndex:0];
        NSString *strTest = [keyArray objectAtIndex:1];
        BOOL isTest = NO;
        if ([strTest compare:@"true"]==NSOrderedSame) {
            isTest = YES;
        }
        _woobooView = [[CommonADView alloc] initWithADWith:tempID status:NO xLocation:0 yLocation:-20 displayType:CommonBannerScreen horizontalOrientation:CommonOrientationPortrait];
        [_woobooView setDisplayType:CommonBannerScreen setX:0 setY:0];
        _woobooView.requestADTimeIntervel = 100000000.00;
        [_woobooView startADRequest];
        //---------- begin: add codes for non-listener ad network track click data
        if (_nonListenerGR==nil) {
            _nonListenerGR = [[UITapGestureRecognizer alloc] initWithTarget:self.adView action:@selector(nonListenerNetworkAdClicked)];
        }        
        _nonListenerGR.delegate = self;
        [_nonListenerGR setNumberOfTapsRequired:1];
        [_nonListenerGR setNumberOfTouchesRequired:1];
        [_nonListenerGR setCancelsTouchesInView:NO];
        [_woobooView addGestureRecognizer:_nonListenerGR];
        //----------- end
        
        if(_woobooView !=nil)
            [self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
        else {
            [self.adView adapter:self didFailToLoadAdWithError:nil];
        }
        [self.adView setAdContentView:_woobooView];
        
    }
}

- (void)receiveAD
{
    [self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void)onFailedToReceiveAD:(NSString*)error 
{
    [self.adView adapter:self didFailToLoadAdWithError:nil];
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
