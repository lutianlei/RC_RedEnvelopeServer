//
//  RC_RedEvNetworkOperator.h
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RC_RedEvNetworkOperator : NSObject

@property (class, nonatomic, readonly)RC_RedEvNetworkOperator *networkOperator;


- (void)downLoadRedEvFileWithURL:(NSString *)urlString
               completionHandler:(void (^)(NSArray *dataList, NSURLResponse *response, NSError *error))completionHandler;

@end
