//
//  RC_RedEnvelopeService.m
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_RedEnvelopeService.h"
#import "RC_RedEvModelOperator.h"
#import "RC_RedEvModel.h"
#import "RC_RedEvTool.h"
#import "RC_RedEnvelopeLogicServer.h"

@implementation RC_RedEnvelopeService

+ (RC_RedEnvelopeService *)service{
    return [RC_RedEnvelopeService shareService];
}

+(instancetype)shareService{
    
    static RC_RedEnvelopeService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[RC_RedEnvelopeService alloc] init];
    });
    
    return service;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)rc_startRedEnvelopeService:(NSString *)urlString{
    
    dispatch_queue_t queue = dispatch_queue_create("com.haodai.xdq.RedeV.rc_start.queue", NULL);
    dispatch_async(queue, ^{
        
        [[RC_RedEvModelOperator modelOperator] setUrlString:urlString];
        [RC_RedEvModelOperator modelOperator].networkComplate = ^(BOOL isSuccess) {
            if (isSuccess) {
                [[RC_RedEnvelopeService service] callRedEvAlert];
            }
        };
    });
    
    
}

// 调用UI业务
- (void)callRedEvAlert{
    // 取
    NSArray *registered_infoList = [NSArray arrayWithContentsOfFile:[RC_RedEvTool getRedEvInfoPathWithType:ERCRedEnvelopeTypeRegistered]];
    NSArray *f_registered_infoList = [NSArray arrayWithContentsOfFile:[RC_RedEvTool getRedEvInfoPathWithType:ERCRedEnvelopeTypeFriendRegistered]];
    NSArray *f_certified_infoList = [NSArray arrayWithContentsOfFile:[RC_RedEvTool getRedEvInfoPathWithType:ERCRedEnvelopeTypeFriendCertified]];

    if (registered_infoList.count > 0) {
        [self operationCallRedEvAlertWithModel:[registered_infoList lastObject]];
    }else if (f_registered_infoList.count > 0) {
        [self operationCallRedEvAlertWithModel:[f_registered_infoList lastObject]];
    }else if (f_certified_infoList.count > 0) {
        [self operationCallRedEvAlertWithModel:[f_certified_infoList lastObject]];
    }
    
}

- (void)operationCallRedEvAlertWithModel:(NSDictionary *)dic{
    RC_RedEvModel *model = [RC_RedEvModel modelWithInfo:dic];
    [[RC_RedEnvelopeLogicServer service] callRedEvAlertWithModel:model callBack:^(BOOL result, RC_RedEvModel *model) {
        if (result) {
            
            dispatch_queue_t queue = dispatch_queue_create("com.haodai.xdq.RedeV.tofile.queue", NULL);
            dispatch_async(queue, ^{
                if ([RC_RedEvTool removeFileWithType:model.reType]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self callRedEvAlert];
                    });
                }
            });
            
        }
    }];
}
@end
