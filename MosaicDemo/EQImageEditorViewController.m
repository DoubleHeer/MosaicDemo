//
//  EQImageEditorViewController.m
//  NewOncon-EasyAsk
//
//  Created by 张飞鹏 on 15/7/31.
//  Copyright (c) 2015年 si-tech. All rights reserved.
//

#import "EQImageEditorViewController.h"
#import "EQRGBColorInfo.h"
#import "EQDrawingPath.h"
#import "EQTouchDrawImageView.h"
#import "AppDelegate.h"
#import "EQNewDrawTool.h"
@interface EQImageEditorViewController ()<UIScrollViewDelegate,EQNewDrawToolSelectBtnDelegate>
@property(nonatomic,weak) IBOutlet UIImageView* drawBgImageView;
@property(nonatomic,weak) IBOutlet EQTouchDrawImageView * drawingView;
@property(nonatomic) float maxW;
@property(nonatomic) float maxH;
@property(nonatomic,strong) NSMutableArray* strokeColorArr;
@property(nonatomic,weak) IBOutlet UIButton * btnOk;
@property(nonatomic) BOOL isResize;
@property (weak, nonatomic) IBOutlet UIView *drawBaseView;
//导航栏的view
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIScrollView *editScrollView;
//纪录放大缩小的倍数
//@property(nonatomic,assign) float editScale;
//@property(nonatomic,assign)BOOL isScale;
//@property(nonatomic,strong)UIView *editView;
//添加彩笔的参数
//@property(nonatomic,strong)EQDrawTool *eqDrawTool;
@property(nonatomic,assign)CGAffineTransform drawTransform;

@property (nonatomic,strong) EQNewDrawTool *newdrawTool;
@end

@implementation EQImageEditorViewController
@synthesize drawBgImageView;
@synthesize drawingView;

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.newdrawTool = [[EQNewDrawTool alloc]init];
    self.newdrawTool.delegate = self;
    [self.view addSubview:self.newdrawTool];
    //    添加画板
    // self.eqDrawTool = [[EQDrawTool alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 150, [UIScreen mainScreen].bounds.size.height - 150, 150,150)];
    
    //    self.drawTransform = self.eqDrawTool.transform;
    //    self.eqDrawTool.delegate = self;
    //    self.eqDrawTool.selectImagview.delegate = self;
    //    [self.view addSubview:self.eqDrawTool];
    //    [self.view bringSubviewToFront:self.eqDrawTool];
    
    
    drawingView.isEndEditing = NO;
    
    //开始为画线模式，无法滚动
    [self.editScrollView setScrollEnabled:NO];
    
    
    //    self.isScale = NO;
    self.editScrollView.contentSize = self.editScrollView.frame.size;
    //设置最大伸缩比例
    self.editScrollView.maximumZoomScale=4.0;
    //设置最小伸缩比例
    self.editScrollView.minimumZoomScale=1;
    //    self.editView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.editScroll.frame.size.width, self.editScroll.frame.size.height)];
    //    UIView * v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    //    [v1 setBackgroundColor:[UIColor blackColor]];
    //    [self.editView addSubview:v1];
    
    //    [self.editView setBackgroundColor:[UIColor redColor]];
    //    [self.editScroll addSubview:self.editView];
    
    
    
    self.strokeColorArr = [[NSMutableArray alloc]init];
    
    
    EQRGBColorInfo * color0 = [[EQRGBColorInfo alloc]init];
    [color0 initColorWithRed:0.976f Green:0.184f Blue:0.137f Alpha:1 IsMosaic:NO];
    [self.strokeColorArr addObject:color0 ];
    
    
    EQRGBColorInfo * color1 = [[EQRGBColorInfo alloc]init];
    [color1 initColorWithRed:0.984f Green:0.502f Blue:0.2f Alpha:1 IsMosaic:NO];
    [self.strokeColorArr addObject:color1 ];
    
    EQRGBColorInfo * color2 = [[EQRGBColorInfo alloc]init];
    [color2 initColorWithRed:0.996f Green:0.878f Blue:0.055 Alpha:1 IsMosaic:NO];
    [self.strokeColorArr addObject:color2 ];
    
    EQRGBColorInfo * color3 = [[EQRGBColorInfo alloc]init];
    [color3 initColorWithRed:0.518f Green:0.918f Blue:0.114f Alpha:1 IsMosaic:NO];
    [self.strokeColorArr addObject:color3 ];
    
    EQRGBColorInfo * color4 = [[EQRGBColorInfo alloc]init];
    [color4 initColorWithRed:0.086f Green:0.569f Blue:0.973f Alpha:1 IsMosaic:NO];
    [self.strokeColorArr addObject:color4 ];
    
    
    EQRGBColorInfo * color5 = [[EQRGBColorInfo alloc]init];
    [color5 initColorWithRed:0.698f Green:0.051f Blue:0.8f Alpha:1 IsMosaic:NO];
    [self.strokeColorArr addObject:color5 ];
    
    EQRGBColorInfo * color6 = [[EQRGBColorInfo alloc]init];
    [color6 initColorWithRed:1 Green:1 Blue:1 Alpha:0 IsMosaic:NO];
    [self.strokeColorArr addObject:color6 ];
    
    EQRGBColorInfo * color7 = [[EQRGBColorInfo alloc]init];
    [color7 initColorWithRed:1 Green:1 Blue:1 Alpha:0 IsMosaic:YES];
    [self.strokeColorArr addObject:color7 ];
    
    EQRGBColorInfo * color8 = [[EQRGBColorInfo alloc]init];
    [color8 initColorWithRed:0 Green:0 Blue:0 Alpha:1 IsMosaic:NO];
    [self.strokeColorArr addObject:color8 ];
    if (self.btnOkTitle) {
        [self.btnOk setTitle:self.btnOkTitle forState:UIControlStateNormal];
    }
    self.isResize = NO;
    //    self.drawColor = self.strokeColorArr[0] ;
    //    self.strokeWidth = 3.0f;
    if (!self.drawingImg) {
        return;
    }
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (drawingView.isEndEditing)
    {
        return self.drawBaseView;
    } else {
        return nil;
    }
    
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.drawingImg && self.isResize == NO) {
        UIImage*img = self.drawingImg;
        [self resizeDrawImageView:img];
        [self.drawBgImageView setImage:img];
        drawingView.strokeWidth = 2.0f;
        drawingView.strokeColor = self.strokeColorArr[2];
        drawingView.scaleW = img.size.width/self.drawBgImageView.frame.size.width;
        drawingView.scaleH = img.size.height/self.drawBgImageView.frame.size.height;
        [drawingView mosaicImageByImage:self.drawingImg];
    }
    
    self.isResize = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 调整画布和image的大小
-(void) resizeDrawImageView:(UIImage*)img {
    
    float frmW = self.view.frame.size.width;
    float frmH = self.view.frame.size.height;
    
    self.editScrollView.frame = CGRectMake(0, 64, frmW, frmH-64);
    float maxH = self.drawBgImageView.frame.size.height;
    float maxW = self.drawBgImageView.frame.size.width;
    float imgW = img.size.width;
    float imgH = img.size.height;
    
    float x = self.drawBgImageView.frame.origin.x;
    float y = self.drawBgImageView.frame.origin.y;
    float w = 0;
    float h = 0;
    if (imgW <=maxW && imgH<=maxH) {
        w = imgW;
        h = imgH;
    } else if(imgW<=maxW && imgH > maxH) {
        w = (maxH*imgW) /imgH;
        h = maxH;
    } else if (imgW>maxW && imgH <= maxH) {
        w = maxW;
        h = (maxW*imgH)/imgW;
    } else {
        float sW = maxW/imgW;
        float sH = maxH/imgH;
        if (sW<sH) {
            w = imgW * sW;
            h = imgH * sW;
        } else {
            w = imgW * sH;
            h = imgH * sH;
        }
        
    }
    
    x = (maxW - w)/2;
    y = (maxH - h)/2 ;
    
    [self.drawBgImageView setFrame:CGRectMake(x, y, w, h)];
    [drawingView setFrame:CGRectMake(x, y, w, h)];
    self.editScrollView.contentSize = CGSizeMake(w, h);
    
    //    [drawingView setBackgroundColor:[UIColor redColor]];
    //    [self.editView setFrame:CGRectMake(x, y + 64, w, h)];
    
    //    [self.view sendSubviewToBack:self.editScroll];
    //    [self.view bringSubviewToFront:drawingView];
    
}
#pragma -mark button
-(IBAction)cancelEditImgage:(id)sender {
    NSLog(@"正在取消");
    [drawingView removeAllUndoActionsList];
    if (self.delegate) {
        [self.delegate cancelEditImageWithParams:self.params];
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)didFinishEditImgage:(id)sender {
    
    [self.btnOk setEnabled:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [drawingView removeAllUndoActionsList];
        
        UIImage * img = [self buildDrawingImage];
        if (self.delegate) {
            [self.delegate didEndEditImage:img withParams:self.params];
        }
        
        
        [self dismissViewControllerAnimated:NO completion:^{
            
            
        }];
        
        
    });
    
    
    return;
    
    
}
//- (IBAction)clearAllBtnClicked:(id)sender {
//    [drawingView removeAllDrawPaths];
//}
#pragma mark 原来 左下角的取消编辑按钮
//-(IBAction)undoDrawing:(id)sender
//{
//    [drawingView undo];
//
//}
-(UIImage *) buildDrawingImage {
    UIImage * img = self.drawingImg;
    NSArray * drawPaths = [drawingView getDrawPathsArray];
    if (drawPaths && drawPaths.count>0) {
        
        
        
        UIGraphicsBeginImageContextWithOptions(self.drawingImg.size,YES,1.0f);
        //    UIGraphicsBeginImageContext
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //抗锯齿
        CGContextSetAllowsAntialiasing(context, YES);
        CGContextSetShouldAntialias (context, YES);
        
        //线宽
        //        CGContextSetLineWidth(context,4);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        //设置画笔颜色
        [self.drawingImg drawInRect:CGRectMake(0, 0,self.drawingImg.size.width,self.drawingImg.size.height)];
        
        
        float scaleW = drawingView.scaleW;
        float scaleH = drawingView.scaleH;
        //        for (EQDrawingPath *path in drawPaths) {
        //            if ([path color].a == 0) {
        //                CGContextSetBlendMode(context, kCGBlendModeSourceIn);
        //            } else {
        //                CGContextSetBlendMode(context,kCGBlendModeNormal);
        //            }
        //            CGContextSetRGBStrokeColor(context,path.color.r,path.color.g,path.color.b,path.color.a);
        //            CGContextBeginPath(context);
        //            CGContextMoveToPoint(context, path.begin.x * scaleW, path.begin.y * scaleH);
        //            CGContextAddLineToPoint(context, path.end.x * scaleW, path.end.y * scaleH);
        //            CGContextStrokePath(context);
        //
        //        }
        
        CGAffineTransform t = drawingView.transform;
        CGAffineTransform newTransform = CGAffineTransformScale(t,scaleW,scaleH);
        [drawingView setTransform:newTransform];
        CGRect rect = drawingView.frame;
        drawingView.center = CGPointMake(rect.size.width/2, rect.size.height/2);
        [drawingView.layer setBounds:drawingView.frame];
        
        [drawingView.layer renderInContext:context];
        img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();//移除画布
        
        
    }
    return img;
}


-(void)editStateChange:(BOOL) isEndEditing
{
    drawingView.isEndEditing=isEndEditing;
    if (isEndEditing) {
        [self.editScrollView setScrollEnabled:YES];
        
    } else {
        [self.editScrollView setScrollEnabled:NO];
        
    }
    
}



#pragma mark - 根据按钮Tag改变 颜色
-(void)selectColorByCurrentTag:(NSInteger)tag {
    if (tag == 111) {// 清除
        drawingView.strokeColor = self.strokeColorArr[6] ;
    }
    if (tag == 112) { //马赛克
        drawingView.strokeColor = self.strokeColorArr[7] ;
    }
    if (tag == 113) { //蓝
        drawingView.strokeColor = self.strokeColorArr[4] ;
    }
    if (tag == 114) { //黄
        drawingView.strokeColor = self.strokeColorArr[2] ;
    }
    if (tag == 115) { //红
        drawingView.strokeColor = self.strokeColorArr[0] ;
    }
    if (tag == 116) { //黑
        drawingView.strokeColor = self.strokeColorArr[8] ;
    }
}

@end
