//
//  ViewController.m
//  MosaicDemo
//
//  Created by heer on 16/7/26.
//  Copyright © 2016年 heer. All rights reserved.
//

#import "ViewController.h"
#import "EQImageEditorViewController.h"

@interface ViewController ()<EQImageEditorDelegate>
@property (nonatomic,strong) UIImageView *imageview1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image1 = [UIImage imageNamed:@"aaa.jpg"];
    UIImageView *imageview1 = [[UIImageView alloc]initWithImage:image1];
    imageview1.frame = CGRectMake(20, 20, 200, 200);
    imageview1.contentMode = UIViewContentModeScaleAspectFit;
    //imageview1.backgroundColor = [UIColor blueColor];
    self.imageview1 = imageview1;
    [self.view addSubview:self.imageview1];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget: self action:@selector(editImageView:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(50, 250, 100, 40);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

-(void)editImageView:(UIButton *)sender {
    EQImageEditorViewController * ctrler = [[EQImageEditorViewController alloc]init];
    ctrler.drawingImg = self.imageview1.image;
  
    ctrler.delegate = self;
    [self presentViewController:ctrler animated:YES completion:nil];
}

#pragma -mark EQImageEditorDelegate
-(void) didEndEditImage:(UIImage*) img withParams:(NSDictionary*) dic {
   
    self.imageview1.image = img;
  
}
-(void) cancelEditImageWithParams:(NSDictionary*) dic{
    // do nothing
}



@end
