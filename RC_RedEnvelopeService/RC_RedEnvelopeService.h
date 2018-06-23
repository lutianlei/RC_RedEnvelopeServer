//
//  RC_RedEnvelopeService.h
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RC_RedEvModel.h"

@interface RC_RedEnvelopeService : NSObject

@property (class, nonatomic, readonly)RC_RedEnvelopeService *service;

- (void)rc_startRedEnvelopeService:(NSString *)urlString;

@end
