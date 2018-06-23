//
//  RC_RedEvModel.m
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_RedEvModel.h"

static ERCRedEnvelopeType map(NSInteger type_idx){
    ERCRedEnvelopeType type = ERCRedEnvelopeTypeRegistered;
    if (type_idx == 2) {
        type = ERCRedEnvelopeTypeFriendRegistered;
    }else if (type_idx == 3) {
        type = ERCRedEnvelopeTypeFriendCertified;
    }
    
    return type;
}

@interface RC_RedEvModel ()

@property (copy, nonatomic, readwrite) NSString *rid;
@property (assign, nonatomic, readwrite) ERCRedEnvelopeType reType;

@end

@implementation RC_RedEvModel

+ (RC_RedEvModel *)modelWithInfo:(NSDictionary *)dic{
    RC_RedEvModel *model = [RC_RedEvModel new];
    
    model.rid = dic[@"rid"];
    model.reType = map([dic[@"reType"] integerValue]);
    
    return model;
}

+ (NSArray<RC_RedEvModel *> *)modelArrWithInfoArr:(NSArray *)infoArr{
    
    NSMutableArray *mutaArr = [NSMutableArray array];
    for (NSDictionary *dic in infoArr) {
        [mutaArr addObject:[RC_RedEvModel modelWithInfo:dic]];
    }
    return [NSArray arrayWithArray:mutaArr];
}

@end
