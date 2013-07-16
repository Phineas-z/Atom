//
//  AdWhirlAdapterVpon.m
//  AdwirlDemo
//
//  Created by luyuanshuo on 13-7-16.
//  Copyright (c) 2013年 luyuanshuo. All rights reserved.
//

#import "AdWhirlAdapterVpon.h"
#import "AdWhirlView.h"
#import "AdWhirlConfig.h"
#import "AdWhirlAdNetworkConfig.h"
#import "AdWhirlAdNetworkAdapter+Helpers.h"
#import "AdWhirlAdNetworkRegistry.h"
#import "VponAdOn.h"

@interface AdWhirlAdapterVpon()<VponAdOnDelegate>
@end

@implementation AdWhirlAdapterVpon

+(AdWhirlAdNetworkType)networkType{
    return AdWhirlAdNetworkTypeVpon;//
}

+(void)load{
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:[self class]];
}

-(void)getAd{
    [VponAdOn initializationPlatform:CN];
    [[VponAdOn sharedInstance] setIsVponLogo:YES];
    [[VponAdOn sharedInstance] setLocationOnOff:YES];
    
    self.adNetworkView = [[[VponAdOn sharedInstance] requestDelegate:self LicenseKey:[self licenseKey] size:ADON_SIZE_320x48].lastObject view];
}

-(void)stopBeingDelegate{
    [[VponAdOn sharedInstance] setAdOnDelegate:nil];
    
    self.adNetworkView = nil;
}

-(NSArray*)licenseKey{
    if (networkConfig.pubId && ![networkConfig.pubId isEqualToString:@""]) {
        return @[networkConfig.pubId];
    }else{
        return nil;
    }
}

#pragma mark - VponAdOnDelegate
-(void)onRecevieAd:(UIViewController *)bannerView withLicenseKey:(NSString *)licenseKey{
    [adWhirlView adapter:self didReceiveAdView:bannerView.view];
}

-(void)onFailedToRecevieAd:(UIViewController *)bannerView withLicenseKey:(NSString *)licenseKey{
    [adWhirlView adapter:self didFailAd:nil];
}

@end
