//
//  RC_RedEvModel.h
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RC_RedEvExtension.h"

@interface RC_RedEvModel : NSObject

@property (copy, nonatomic, readonly) NSString *rid;
@property (assign, nonatomic, readonly) ERCRedEnvelopeType reType;

+ (RC_RedEvModel *)modelWithInfo:(NSDictionary *)dic;
+ (NSArray <RC_RedEvModel *>*)modelArrWithInfoArr:(NSArray *)infoArr;

@end
