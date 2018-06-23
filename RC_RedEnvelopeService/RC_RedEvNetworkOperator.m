//
//  RC_RedEvNetworkOperator.m
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_RedEvNetworkOperator.h"

static NSString *const kJsonResponseStatusKey = @"rs_code";
static NSInteger const kJsonResponseSucceed = 1000;

static NSString *const kDetails = @"details";



@implementation RC_RedEvNetworkOperator

+ (RC_RedEvNetworkOperator *)networkOperator{
    return [RC_RedEvNetworkOperator shareOperator];
}

+(instancetype)shareOperator{
    
    static RC_RedEvNetworkOperator *operator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operator = [[RC_RedEvNetworkOperator alloc] init];
    });
    
    return operator;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)downLoadRedEvFileWithURL:(NSString *)urlString
               completionHandler:(void (^)(NSArray *dataList, NSURLResponse *response, NSError *error))completionHandler {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
                                                                     
                                                                     // 如果网络请求成功
                                                                     if (error == nil) {
                                                                         
                                                                         NSError *hdError = nil;
                                                                         id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&hdError];
                                                                         
                                                                         if (hdError) {
                                                                             
                                                                             // 解析失败请求失败
                                                                             if (completionHandler) {
                                                                                 completionHandler(nil, response, error);
                                                                             }
                                                                         }else {
                                                                             
                                                                             NSDictionary *jsonDic = json;
                                                                             
                                                                             if ([jsonDic[kJsonResponseStatusKey] integerValue] == kJsonResponseSucceed) {
                                                                                 
                                                                                 NSArray *dataArr = jsonDic[kDetails];
                                                                                 
                                                                                 if (completionHandler) {
                                                                                     completionHandler(dataArr, response, nil);
                                                                                 }
                                                                                 
                                                                             }else {
                                                                                 
                                                                                 if (completionHandler) {
                                                                                     completionHandler(nil, response, nil);
                                                                                 }
                                                                             }
                                                                         }
                                                                     }else {
                                                                         
                                                                         // 网络请求失败
                                                                         if (completionHandler) {
                                                                             completionHandler(nil, response, error);
                                                                         }
                                                                         
                                                                     }
                                                                 }];
    [task resume];
}


@end
