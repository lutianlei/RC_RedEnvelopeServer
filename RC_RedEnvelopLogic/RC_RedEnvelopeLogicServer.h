//
//  RC_RedEnvelopeLogicServer.h
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RC_RedEvModel.h"

typedef void(^RC_RedEnvelopeLogicServerCallBack)(BOOL result, RC_RedEvModel *model);

@interface RC_RedEnvelopeLogicServer : NSObject

@property (class, nonatomic, readonly)RC_RedEnvelopeLogicServer *service;

- (void)callRedEvAlertWithModel:(RC_RedEvModel *)model callBack:(RC_RedEnvelopeLogicServerCallBack)callBack;

@end
