//
//  RC_RedEnvelopeLogicServer.m
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_RedEnvelopeLogicServer.h"
#import "RC_RedEvAlert.h"

@interface RC_RedEnvelopeLogicServer()

@property (copy, nonatomic) RC_RedEnvelopeLogicServerCallBack callBack;

@property (strong, nonatomic) RC_RedEvModel *model;

@end

@implementation RC_RedEnvelopeLogicServer


+ (RC_RedEnvelopeLogicServer *)service{
    return [RC_RedEnvelopeLogicServer shareService];
}

+(instancetype)shareService{
    
    static RC_RedEnvelopeLogicServer *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[RC_RedEnvelopeLogicServer alloc] init];
    });
    
    return service;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)callRedEvAlertWithModel:(RC_RedEvModel *)model callBack:(RC_RedEnvelopeLogicServerCallBack)callBack{
    self.callBack = callBack;
    self.model = model;
    
    [RC_RedEvAlert showWithModel:self.model callBack:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.callBack(YES,self->_model);
        });
    }];

}

@end
