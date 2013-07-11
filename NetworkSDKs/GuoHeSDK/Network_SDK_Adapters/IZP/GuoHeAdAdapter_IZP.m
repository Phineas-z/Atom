//
//  GuoHeAdAdapter_IZP.m
//  GuoHeProiOSDev
//
//  Created by Wulin on 27/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_IZP.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_IZP

static BOOL isFirst = YES;
static IZPView *adBannerView = nil;

- (void)dealloc
{
	[adBannerView setDelegate:nil];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
    NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>1) {
        if (isFirst) {
            NSString *tempID = [keyArray objectAtIndex:0];
            NSString *strTest = [keyArray objectAtIndex:1];
            Model isTest = MODEL_RELEASE;
            if ([strTest compare:@"true"]==NSOrderedSame) {
                isTest = MODEL_TEST;
            }
            [IZPView setPID:tempID adType:AD_TYPE_BANNER model:isTest];
            isFirst = NO;
        }
        
        CGRect frame = CGRectMake(self.adView.adParentView.frame.origin.x, self.adView.adParentView.frame.origin.y, adsize.width, adsize.height);
    
        if (adBannerView == nil) {
            adBannerView = [[IZPView alloc] initWithFrame:frame];
        }
        [adBannerView start];
		[adBannerView setDelegate:self];
        
        if (adBannerView) {
            [self.adView setAdContentView:adBannerView];
            [self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
        }
        
	}
    else{
        NSLog(@"App IZP key null..");
    }

}

- (void) errorReport:(NSInteger)code erroInfo:(NSString*) info
{
    [adBannerView pause];
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (void)willLeaveApplication:(IZPView*)view
{
    [self.adView nonListenerNetworkAdClicked];
}

- (void)adapterWillDealloc
{
    [adBannerView pause];
}

@end
