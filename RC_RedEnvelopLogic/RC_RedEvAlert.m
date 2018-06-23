//
//  RC_RedEvAlert.m
//  RC_RedEnvelopeDemo
//
//  Created by lutianlei on 2018/6/23.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_RedEvAlert.h"
#import "RC_RedEvModel.h"

@interface RC_RedEvAlert()

@property (copy, nonatomic) RC_RedEvAlertOperationComplate operComplate;

@end

@implementation RC_RedEvAlert

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

+ (void)showWithModel:(id)model callBack:(RC_RedEvAlertOperationComplate)callback{
    
    if (model && [model isKindOfClass:[RC_RedEvModel class]]) {
        
        RC_RedEvAlert *alert = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RC_RedEvAlert class]) owner:nil options:nil] lastObject];
        
        alert.operComplate = callback;
        
        [alert show];
        
    }
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.frame = window.bounds;
    self.alpha = 0.0;
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha = 0.0;
        [self removeFromSuperview];
        self.operComplate();
    }];
}

- (IBAction)buttonActin:(UIButton *)sender{

    [self dismiss];
    
//    if (sender.tag == 1001) {
//
//    }else if (sender.tag == 1002) {
//
//    }else if (sender.tag == 1003) {
//
//    }
    
}



@end
