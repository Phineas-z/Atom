//
//  GuoHeAdAdapter_Wooboo.h
//  GuoHeProiOSDev
//
//  Created by Wulin on 05/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonADView.h"
#import "GHBaseAdapter.h"

@interface GuoHeAdAdapter_Wooboo : GHBaseAdapter <UIGestureRecognizerDelegate>{
    CommonADView *_woobooView;
    UITapGestureRecognizer *_nonListenerGR;
}

@end
