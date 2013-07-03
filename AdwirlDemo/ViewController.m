//
//  ViewController.m
//  AdwirlDemo
//
//  Created by luyuanshuo on 13-7-3.
//  Copyright (c) 2013年 luyuanshuo. All rights reserved.
//

#import "ViewController.h"
#import "AdWhirlView.h"

@interface ViewController ()<AdWhirlDelegate>
@property (nonatomic, retain) AdWhirlView* adView;
@end

@implementation ViewController

-(void)dealloc{
    self.adView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    self.adView.frame = CGRectMake((CGRectGetWidth(self.view.bounds)-300)/2, (CGRectGetHeight(self.view.bounds)-250)/2, 300, 250);
    [self.view addSubview:self.adView];
}

#pragma mark - AdWhirlDelegate
- (NSString *)adWhirlApplicationKey{
    return @"6e8cef50e3d64635aad76ed514d738ae";
}

- (UIViewController *)viewControllerForPresentingModalView{
    return self;
}

- (NSURL *)adWhirlConfigURL{
    return [NSURL URLWithString:@"http://m.ads.appublisher.com/getinfo.php"];
}

- (NSURL *)adWhirlImpMetricURL{
    return [NSURL URLWithString:@"http://m.ads.appublisher.com/exmet.php"];
}

- (NSURL *)adWhirlClickMetricURL{
    return [NSURL URLWithString:@"http://m.ads.appublisher.com/exclick.php"];
}

@end
