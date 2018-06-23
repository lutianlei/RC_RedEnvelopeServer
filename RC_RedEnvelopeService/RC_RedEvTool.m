//
//  RC_RedEvTool.m
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/22.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_RedEvTool.h"

static NSString *const kOperationTBimageFolderPath = @"red_ev";           // 红包文件夹
static NSString *const kRedEvRegisteredInfoPath = @"re_Registered_infos";                // 注册红包信息
static NSString *const kRedEvFriendRegisteredInfoPath = @"re_FriendRegistered_infos";                // 好友注册红包信息
static NSString *const kRedEvFriendCertifiedInfoPath = @"re_FriendCertified_infos";                // 好友认证红包信息


@implementation RC_RedEvTool

/**创建红包文件夹*/
+(NSString *)getRedEvFolderPath {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *tbImageFold = [docPath stringByAppendingPathComponent:kOperationTBimageFolderPath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:tbImageFold]) {
        
        BOOL suss = [[NSFileManager defaultManager] createDirectoryAtPath:tbImageFold
                                              withIntermediateDirectories:YES
                                                               attributes:nil
                                                                    error:nil];
        if (!suss) {
            NSLog(@"创建TabBar图片目录失败！");
        }
    }
    
    return tbImageFold;
}

/**获取TB信息plist文件路径*/
+ (NSString *)getRedEvInfoPathWithType:(ERCRedEnvelopeType)rc_type{
    NSString *kPathComponent = nil;
    if (rc_type == ERCRedEnvelopeTypeRegistered) {
        kPathComponent = kRedEvRegisteredInfoPath;
    }else if (rc_type == ERCRedEnvelopeTypeFriendRegistered) {
        kPathComponent = kRedEvFriendRegisteredInfoPath;
    }else if (rc_type == ERCRedEnvelopeTypeFriendCertified) {
        kPathComponent = kRedEvFriendCertifiedInfoPath;
    }
    return [[RC_RedEvTool getRedEvFolderPath] stringByAppendingPathComponent:kPathComponent];
}

+ (BOOL)removeFileWithType:(ERCRedEnvelopeType)reType{
    return [RC_RedEvTool removeFileWithPath:nil WithType:reType];
}

/**删除某个文件*/
+ (BOOL)removeFileWithPath:(NSString *)path WithType:(ERCRedEnvelopeType)reType{
    
    if (path) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath:path]){
            
            NSError *error = nil;
            
            [fileManager removeItemAtPath:path error:&error];
            
            if (error) {
                NSLog(@"删除文件出错%@",error);
            }else{
                return YES;
            }
        }
    }else{
        NSArray *infoArray = [NSArray arrayWithContentsOfFile:[RC_RedEvTool getRedEvInfoPathWithType:reType]];
        NSMutableArray *mut_infoArray = [NSMutableArray arrayWithArray:infoArray];
        [mut_infoArray removeLastObject];
        infoArray = [NSArray arrayWithArray:mut_infoArray];
        // 做相应的保存操作
        if ([infoArray writeToFile:[RC_RedEvTool getRedEvInfoPathWithType:reType] atomically:YES]){
            return YES;
        }
    }
    
    
    return NO;
}

@end
