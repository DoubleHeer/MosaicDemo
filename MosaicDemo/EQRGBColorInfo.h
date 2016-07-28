//
//  EQRGBColorInfo.h
//  NewOncon-EasyAsk
//
//  Created by 张飞鹏 on 15/8/1.
//  Copyright (c) 2015年 si-tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQRGBColorInfo : NSObject
@property(nonatomic) float r;
@property(nonatomic) float g;
@property(nonatomic) float b;
@property(nonatomic) float a;
@property(nonatomic) BOOL isMosaic;
-(void) initColorWithRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)a IsMosaic:(BOOL)isMosaic;
@end
