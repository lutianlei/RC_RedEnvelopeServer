//
//  RC_RedEvModelOperator.m
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_RedEvModelOperator.h"
#import "RC_RedEvNetworkOperator.h"
#import "RC_RedEvTool.h"
#import "RC_RedEvModel.h"

@implementation RC_RedEvModelOperator


+ (RC_RedEvModelOperator *)modelOperator{
    return [RC_RedEvModelOperator shareOperator];
}

+(instancetype)shareOperator{
    
    static RC_RedEvModelOperator *operator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operator = [[RC_RedEvModelOperator alloc] init];
    });
    
    return operator;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    [self loadLocalTestPlist];
}

- (void)setNetworkComplate:(RC_RedEvModelOperatorNetworkComplate)networkComplate{
    _networkComplate = networkComplate;
}

- (void)loadLocalTestPlist{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"RC_RedEvTestPlist" ofType:@"plist"];
        NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
        // 数据分组排序
        [self groupOperation:dataList];
    });
    
}
/**
 network request
 */
- (void)loadSource{
    [[RC_RedEvNetworkOperator networkOperator] downLoadRedEvFileWithURL:_urlString
                                                      completionHandler:^(NSArray *dataList, NSURLResponse *response, NSError *error) {
                                                          if (error == nil) {     // 请求成功
                                                              
                                                              if (dataList.count > 0) {
                                                                  
                                                                  // 数据分组排序
                                                                  [self groupOperation:dataList];
                                                                  
                                                              } else {
                                                                  self.networkComplate(YES);
                                                              }
                                                              
                                                          }else {      // 请求失败
                                                              self.networkComplate(NO);
                                                          }
                                                      }];
}

- (void)groupOperation:(NSArray *)infoList{
    
    NSMutableArray *registered_infoList = [NSMutableArray new];
    NSMutableArray *f_registered_infoList = [NSMutableArray new];
    NSMutableArray *f_certified_infoList = [NSMutableArray new];
    
    for (NSDictionary *dic in infoList) {
        RC_RedEvModel *model = [RC_RedEvModel modelWithInfo:dic];
        if (model.reType == ERCRedEnvelopeTypeRegistered) {
            [registered_infoList addObject:dic];
        }else if (model.reType == ERCRedEnvelopeTypeFriendRegistered) {
            [f_registered_infoList addObject:dic];
        }else if (model.reType == ERCRedEnvelopeTypeFriendCertified) {
            [f_certified_infoList addObject:dic];
        }
    }
    
    //存储
    dispatch_queue_t queue = dispatch_queue_create("com.haodai.xdq.RedeV.tofile.queue", NULL);
    dispatch_sync(queue, ^{
        
        if (registered_infoList.count > 0) {
            [registered_infoList writeToFile:[RC_RedEvTool getRedEvInfoPathWithType:ERCRedEnvelopeTypeRegistered] atomically:YES];
        }
        if (f_registered_infoList.count > 0) {
            [f_registered_infoList writeToFile:[RC_RedEvTool getRedEvInfoPathWithType:ERCRedEnvelopeTypeFriendRegistered] atomically:YES];
        }
        if (f_certified_infoList.count > 0) {
            [f_certified_infoList writeToFile:[RC_RedEvTool getRedEvInfoPathWithType:ERCRedEnvelopeTypeFriendCertified] atomically:YES];
        }
        self.networkComplate(YES);

    });
    
}



@end
