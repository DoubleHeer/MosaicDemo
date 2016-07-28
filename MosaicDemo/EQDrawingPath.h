//
//  EQDrawingPath.h
//  NewOncon-EasyAsk
//
//  Created by 张飞鹏 on 15/8/2.
//  Copyright (c) 2015年 si-tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "EQRGBColorInfo.h"

@interface EQDrawingPath : NSObject
@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic, retain) EQRGBColorInfo *color;
-(void) initPathWithStart:(CGPoint) start End:(CGPoint) end Color:(EQRGBColorInfo*) rgbColor;

@end
