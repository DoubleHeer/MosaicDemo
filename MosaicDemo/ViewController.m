//
//  ViewController.m
//  MosaicDemo
//
//  Created by heer on 16/7/26.
//  Copyright © 2016年 heer. All rights reserved.
//

#import "ViewController.h"
#import "EQImageEditorViewController.h"
#import "UIImage+fixOrientation.h"

@interface ViewController ()<EQImageEditorDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget: self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(200, 250, 100, 40);
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
}

-(void)chooseImage:(UIButton *)sender {
    //相册是否允许访问
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:imagePickerController animated:YES];
}
-(void)editImageView:(UIButton *)sender {
    EQImageEditorViewController * ctrler = [[EQImageEditorViewController alloc]init];
    ctrler.drawingImg = self.imageview1.image;
  
    ctrler.delegate = self;
    [self presentViewController:ctrler animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissModalViewControllerAnimated:YES];
    
    [self.imageview1 setImage:[[info objectForKey:UIImagePickerControllerOriginalImage]fixOrientation]];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

#pragma -mark EQImageEditorDelegate
-(void) didEndEditImage:(UIImage*) img withParams:(NSDictionary*) dic {
   
    self.imageview1.image = img;
  
}
-(void) cancelEditImageWithParams:(NSDictionary*) dic{
    // do nothing
}



@end
