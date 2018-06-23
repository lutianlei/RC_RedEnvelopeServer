//
//  RC_RedEvAlert.h
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/23.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RC_RedEvAlertOperationComplate)(void);

@interface RC_RedEvAlert : UIView

+ (void)showWithModel:(id)model callBack:(RC_RedEvAlertOperationComplate)callback;

@end
