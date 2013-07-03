//
//  GuoHeAdAdapter_Admob.h
//  GuoHeSDKTest
//
//  Created by Daniel on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "GADBannerViewDelegate.h"
#import "GADBannerView.h"

@class AdMobView;


@interface GuoHeAdAdapter_Admob : GHBaseAdapter <GADBannerViewDelegate>{
    GADBannerView *_adBannerView;
}

@property (nonatomic,retain) GADBannerView *adBannerView;

@end
