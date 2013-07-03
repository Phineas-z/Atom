//
//  GuoHeAdAdapter_MobiSage.h
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 26/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "MobiSageSDK.h"

@interface GuoHeAdAdapter_MobiSage : GHBaseAdapter <UIGestureRecognizerDelegate>
{
    MobiSageAdBanner *_adBannerView;
    UITapGestureRecognizer *_nonListenerGR;
    NSTimer *timer;
}

@property (nonatomic, retain) MobiSageAdBanner *adBannerView;

- (void)failToReceiveAd;

@end
