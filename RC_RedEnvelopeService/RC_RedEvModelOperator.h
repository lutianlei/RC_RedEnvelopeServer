//
//  RC_RedEvModelOperator.h
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RC_RedEvModelOperatorNetworkComplate)(BOOL isSuccess);

@interface RC_RedEvModelOperator : NSObject

@property (class, nonatomic, readonly)RC_RedEvModelOperator *modelOperator;

@property (copy, nonatomic) NSString *urlString;

@property (copy, nonatomic) RC_RedEvModelOperatorNetworkComplate networkComplate;


@end
