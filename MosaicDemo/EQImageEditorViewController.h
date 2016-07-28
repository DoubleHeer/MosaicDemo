//
//  EQImageEditorViewController.h
//  NewOncon-EasyAsk
//
//  Created by 张飞鹏 on 15/7/31.
//  Copyright (c) 2015年 si-tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EQImageEditorDelegate;

@interface EQImageEditorViewController : UIViewController
@property(nonatomic,strong) UIImage * drawingImg;

@property(nonatomic,strong) NSDictionary * params;//前面页面传递过来的参数。本页面消失后，原装返回
@property(assign)id<EQImageEditorDelegate> delegate;
@property(nonatomic,strong) NSString * btnOkTitle;
@end
@protocol EQImageEditorDelegate <NSObject>
-(void) didEndEditImage:(UIImage*) img withParams:(NSDictionary*) dic;
-(void) cancelEditImageWithParams:(NSDictionary*) dic;

@end