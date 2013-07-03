//
//  GuoHeAdAdapter_Domob.h
//  TestGuoHeAd1
//
//  Created by Daniel on 11-5-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "DMAdView.h"

@interface GuoHeAdAdapter_Domob : GHBaseAdapter <DMAdViewDelegate, UIGestureRecognizerDelegate> {
    DMAdView *_doMobView;
    UITapGestureRecognizer *_nonListenerGR;
}

@property (nonatomic,retain) DMAdView *doMobView;
@end
