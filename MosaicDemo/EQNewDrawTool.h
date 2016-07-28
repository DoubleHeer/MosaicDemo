//
//  EQNewDrawTool.h
//  MosaicDemo
//
//  Created by heer on 16/7/27.
//  Copyright © 2016年 heer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EQNewDrawToolSelectBtnDelegate <NSObject>
@optional
-(void)selectColorByCurrentTag:(NSInteger )tag;
@end

@interface EQNewDrawTool : UIView

@property (nonatomic,strong) UIButton *redBtn;
@property (nonatomic,strong) UIButton *yellowBtn;
@property (nonatomic,strong) UIButton *blueBtn;
@property (nonatomic,strong) UIButton *blackBtn;
@property (nonatomic,strong) UIButton *mosaicBtn;
@property (nonatomic,strong) UIButton *raseBtn;

@property (nonatomic,weak) id <EQNewDrawToolSelectBtnDelegate>delegate;
@end
