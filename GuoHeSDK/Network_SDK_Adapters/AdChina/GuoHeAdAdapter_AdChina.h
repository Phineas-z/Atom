//
//  GuoHeAdAdapter_AdChina.h
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 23/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "AdChinaBannerView.h"
#import "AdChinaLocationManager.h"

@interface GuoHeAdAdapter_AdChina : GHBaseAdapter <AdChinaBannerViewDelegate, UIGestureRecognizerDelegate> 
{
    AdChinaBannerView *_adBannerView;
    //UITapGestureRecognizer *_nonListenerGR;
}

@property (nonatomic, retain) AdChinaBannerView *adBannerView;

@end
