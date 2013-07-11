//
//  GuoHeAdAdapter_MobWIN.h
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 26/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "MobWinBannerView.h"
#import "MobWinBannerViewDelegate.h"

@interface GuoHeAdAdapter_MobWIN : GHBaseAdapter <MobWinBannerViewDelegate>
{
    MobWinBannerView *_adBannerView;
}

@property (nonatomic,retain) MobWinBannerView *adBannerView;

@end
