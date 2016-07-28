//
//  EQTouchDrawImageView.m
//  NewOncon-EasyAsk
//
//  Created by heer on 16/7/26.
//  Copyright © 2016年 heer. All rights reserved.
//

#import "EQTouchDrawImageView.h"
#import "EQDrawingPath.h"

@implementation EQTouchDrawImageView
@synthesize strokeWidth;
@synthesize strokeColor;
@synthesize scaleH;
@synthesize scaleW;
- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        drawPaths = [[NSMutableArray alloc] init];
        [self setMultipleTouchEnabled:YES];
        //        [self becomeFirstResponder];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //抗锯齿
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias (context, YES);
    
    //线宽
    CGContextSetLineWidth(context,self.strokeWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
  
    for (EQDrawingPath *path in drawPaths) {
        if ([path color].isMosaic) {
            CGRect rect = CGRectMake(path.begin.x<path.end.x?path.begin.x:path.end.x, path.begin.y<path.end.y?path.begin.y:path.end.y, fabs(path.begin.x-path.end.x), fabs(path.begin.y-path.end.y));
            UIImage *image = [self getImageFromImageWithRect:rect];
            UIGraphicsPushContext( context );
            [image drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
            UIGraphicsPopContext();
        } else {
            if ([path color].a == 0) {
                CGContextSetLineWidth(context,self.strokeWidth*5);
                CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
            } else {
                CGContextSetLineWidth(context,self.strokeWidth);
                CGContextSetBlendMode(context,kCGBlendModeNormal);
            }
            
            CGContextSetRGBStrokeColor(context,[path color].r
                                       ,[path color].g,[path color].b,[path color].a);
            CGContextBeginPath(context);
            
            CGContextMoveToPoint(context, [path begin].x, [path begin].y);
            CGContextAddLineToPoint(context, [path end].x, [path end].y);
            CGContextStrokePath(context);
        }
        
    }
    
    if (strokeColor.isMosaic) {
        CGRect rects = CGRectMake(self.currentPoint.x < self.firstPoint.x ?self.currentPoint.x:self.firstPoint.x, self.currentPoint.y < self.firstPoint.y ? self.currentPoint.y:self.firstPoint.y, fabs(self.firstPoint.x - self.currentPoint.x),fabs( self.firstPoint.y - self.currentPoint.y));
        
        UIImage *img = [self getImageFromImageWithRect:rects];
        UIGraphicsPushContext( context );
        [img drawInRect:CGRectMake(rects.origin.x, rects.origin.y, rects.size.width, rects.size.height)];
        UIGraphicsPopContext();
    }
    
}

//根据给定得图片，从其指定区域截取一张新得图片
-(UIImage *)getImageFromImageWithRect:(CGRect) rect{
    //定义myImageRect，截图的区域
    CGRect myImageRect = rect;
    
    CGImageRef imageRef = self.cutImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef scale:1 orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return smallImage;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.isEndEditing) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self];
    self.firstPoint = location;
    [self.undoManager beginUndoGrouping];
    
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.isEndEditing) {
        return;
    }
    //手指移动时记录上一次的点坐标和当前点坐标
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    CGPoint pastLocation = [touch previousLocationInView:self];
    
    
    self.currentPoint = pastLocation;
    if (!strokeColor.isMosaic) {
        EQDrawingPath * path = [[EQDrawingPath alloc]init];
        [path initPathWithStart:pastLocation End:location Color:strokeColor];
        [self addPath:path];
    }
    [self setNeedsDisplay];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.isEndEditing) {
        return;
    }
    if (strokeColor.isMosaic) {
        EQDrawingPath *path = [[EQDrawingPath alloc]init];
        [path initPathWithStart:self.firstPoint End:self.currentPoint Color:strokeColor];
        [self addPath:path];
    }
    
    [self.undoManager endUndoGrouping];
    
    
}



#pragma -mark undo redo
- (void)undo
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

- (void)redo
{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

- (void)addPath:(EQDrawingPath*)path
{
    [[self.undoManager prepareWithInvocationTarget:self] removePath:path];
    [drawPaths addObject:path];
    //[self setNeedsDisplay];
}

- (void)removePath:(EQDrawingPath*)path
{
    if ([drawPaths containsObject:path]) {
        [[self.undoManager prepareWithInvocationTarget:self] addPath:path];
        [drawPaths removeObject:path];
        //[self setNeedsDisplay];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didMoveToWindow
{
    [self becomeFirstResponder];
}

-(NSArray*) getDrawPathsArray {
    return [NSArray arrayWithArray:drawPaths];
}
-(void) removeAllUndoActionsList {
    [self.undoManager removeAllActions];
}
-(void) removeAllDrawPaths {
    
    
    [self removeAllUndoActionsList];
    [drawPaths removeAllObjects];
    [self setNeedsDisplay];
    
}

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

-(void)mosaicImageByImage:(UIImage *)image {
    self.cutImage = [UIImage new];
    self.cutImage = [self transToMosaicImage:image blockLevel:10];
    self.cutImage = [self image:self.cutImage byScalingToSize:self.frame.size];
    
}

//改变图片尺寸
- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}
/*
 *转换成马赛克,level代表一个点转为多少level*level的正方形
 */
- (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,width,height,kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData (context);
    
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1)*width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }
    
    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              kBitsPerComponent,
                                              kBitsPerPixel,
                                              width*kPixelChannelCount ,
                                              colorSpace,
                                              kCGImageAlphaPremultipliedLast,
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       kBitsPerComponent,
                                                       width*kPixelChannelCount,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage;
    
}
@end
