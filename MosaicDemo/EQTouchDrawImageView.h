//
//  EQTouchDrawImageView.h
//  NewOncon-EasyAsk
//
//  Created by heer on 16/7/26.
//  Copyright © 2016年 heer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQRGBColorInfo.h"
@interface EQTouchDrawImageView : UIView
{
    NSMutableArray *drawPaths;
    NSMutableArray *mosaicArr;
}
@property (nonatomic) CGPoint firstPoint;
@property (nonatomic) CGPoint currentPoint;
@property (nonatomic,strong) UIImage *cutImage;
@property(nonatomic) EQRGBColorInfo * strokeColor;
@property(nonatomic) CGFloat strokeWidth;
@property(nonatomic) float scaleW;
@property(nonatomic) float scaleH;
@property(nonatomic) BOOL isEndEditing;
-(NSArray*) getDrawPathsArray ;
- (void)undo;
- (void)redo;
- (void) removeAllUndoActionsList;
- (void) removeAllDrawPaths ;
-(void)mosaicImageByImage:(UIImage *)image;
@end
