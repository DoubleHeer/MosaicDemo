//
//  EQDrawingPath.m
//  NewOncon-EasyAsk
//
//  Created by 张飞鹏 on 15/8/2.
//  Copyright (c) 2015年 si-tech. All rights reserved.
//

#import "EQDrawingPath.h"

@implementation EQDrawingPath
-(void) initPathWithStart:(CGPoint) start End:(CGPoint) end Color:(EQRGBColorInfo*) rgbColor
{
    self.begin = start;
    self.end = end;
    self.color = rgbColor;
}


@end
