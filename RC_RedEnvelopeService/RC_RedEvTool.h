//
//  RC_RedEvTool.h
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RC_RedEvExtension.h"


@interface RC_RedEvTool : NSObject

/**创建红包文件夹*/
+(NSString *)getRedEvFolderPath;

/**获取TB信息plist文件路径*/
+ (NSString *)getRedEvInfoPathWithType:(ERCRedEnvelopeType)type;

/**删除某个文件*/
+ (BOOL)removeFileWithType:(ERCRedEnvelopeType)reType;
@end
