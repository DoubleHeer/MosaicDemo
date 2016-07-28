//
//  EQRGBColorInfo.m
//  NewOncon-EasyAsk
//
//  Created by 张飞鹏 on 15/8/1.
//  Copyright (c) 2015年 si-tech. All rights reserved.
//

#import "EQRGBColorInfo.h"

@implementation EQRGBColorInfo
-(void) initColorWithRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)a IsMosaic:(BOOL)isMosaic {

    self.r=r;
    self.g=g;
    self.b=b;
    self.a=a;
    self.isMosaic = isMosaic;

}
@end
