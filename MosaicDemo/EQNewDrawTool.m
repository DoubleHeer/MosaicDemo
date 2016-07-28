//
//  EQNewDrawTool.m
//  MosaicDemo
//
//  Created by heer on 16/7/27.
//  Copyright © 2016年 heer. All rights reserved.
//

#import "EQNewDrawTool.h"

@interface EQNewDrawTool()
@property (nonatomic) NSInteger selectBtnTag;
@end
@implementation EQNewDrawTool



-(UIButton *)blackBtn {
    if (!_blackBtn) {
        _blackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _blackBtn.tag = 116;
        [_blackBtn addTarget:self action:@selector(changeSelectState:) forControlEvents:UIControlEventTouchUpInside];
        [_blackBtn setImage:[UIImage imageNamed:@"edit_img_black"] forState:UIControlStateNormal];
        //[_blackBtn setImage:[UIImage imageNamed:@"edit_img_red_1"] forState:UIControlStateSelected];
    }
    return _blackBtn;
}
-(UIButton *)redBtn {
    if (!_redBtn) {
        _redBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _redBtn.tag = 115;
        [_redBtn addTarget:self action:@selector(changeSelectState:) forControlEvents:UIControlEventTouchUpInside];
        [_redBtn setImage:[UIImage imageNamed:@"edit_img_red"] forState:UIControlStateNormal];
        //[_redBtn setImage:[UIImage imageNamed:@"edit_img_red_1"] forState:UIControlStateSelected];
    }
    return _redBtn;
}

-(UIButton *)yellowBtn {
    if (!_yellowBtn) {
        _yellowBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _yellowBtn.tag = 114;
        [_yellowBtn addTarget:self action:@selector(changeSelectState:) forControlEvents:UIControlEventTouchUpInside];
        [_yellowBtn setImage:[UIImage imageNamed:@"edit_img_yello"] forState:UIControlStateNormal];
        //[_yellowBtn setImage:[UIImage imageNamed:@"edit_img_yello_1"] forState:UIControlStateSelected];
    }
    return _yellowBtn;
}


-(UIButton *)blueBtn {
    if (!_blueBtn) {
        _blueBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _blueBtn.tag = 113;
        [_blueBtn addTarget:self action:@selector(changeSelectState:) forControlEvents:UIControlEventTouchUpInside];
        [_blueBtn setImage:[UIImage imageNamed:@"edit_img_blue"] forState:UIControlStateNormal];
        //[_blueBtn setImage:[UIImage imageNamed:@"edit_img_blue_1"] forState:UIControlStateSelected];
    }
    return _blueBtn;
}

-(UIButton *)mosaicBtn {
    if (!_mosaicBtn) {
        _mosaicBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _mosaicBtn.tag = 112;
        [_mosaicBtn addTarget:self action:@selector(changeSelectState:) forControlEvents:UIControlEventTouchUpInside];
        [_mosaicBtn setImage:[UIImage imageNamed:@"edit_img_mosaic"] forState:UIControlStateNormal];
        //[_mosaicBtn setImage:[UIImage imageNamed:@"edit_img_red_1"] forState:UIControlStateSelected];
    }
    return _mosaicBtn;
}
-(UIButton *)raseBtn {
    if (!_raseBtn) {
        _raseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _raseBtn.tag = 111;
        [_raseBtn addTarget:self action:@selector(changeSelectState:) forControlEvents:UIControlEventTouchUpInside];
        [_raseBtn setImage:[UIImage imageNamed:@"edit_img_enrase"] forState:UIControlStateNormal];
        //[_raseBtn setImage:[UIImage imageNamed:@"edit_img_enrase_1"] forState:UIControlStateSelected];
    }
    return _raseBtn;
}

-(instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        CGRect rect = [UIScreen mainScreen].bounds;
        CGFloat interval = (rect.size.width-45*6)/7;
        self.frame = CGRectMake(0, rect.size.height-60, rect.size.width, 60);
        [self addSubview:self.raseBtn];
        self.raseBtn.frame = CGRectMake(interval, 7, 45, 45);
        [self addSubview:self.mosaicBtn];
        self.mosaicBtn.frame = CGRectMake(interval*2+45*1, 7, 45, 45);
        [self addSubview:self.blueBtn];
        self.blueBtn.frame = CGRectMake(interval*3+45*2, 7, 45, 45);
        [self addSubview:self.yellowBtn];
        self.yellowBtn.frame = CGRectMake(interval*4+45*3, 7, 45, 45);
        [self addSubview:self.redBtn];
        self.redBtn.frame = CGRectMake(interval*5+45*4, 7, 45, 45);
        [self addSubview:self.blackBtn];
        self.blackBtn.frame = CGRectMake(interval*6+45*5, 7, 45, 45);
        
        self.yellowBtn.selected = YES;
        self.yellowBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.yellowBtn.layer.borderWidth = 1.0f;
        self.selectBtnTag = self.yellowBtn.tag;
    }
    return self;
}
-(void)changeSelectState:(UIButton *)sender {
    NSInteger currentTag = sender.tag;
    if (currentTag == self.selectBtnTag) {
        return;
    }
    UIButton *button = (UIButton *)[self viewWithTag:self.selectBtnTag];
    button.selected = NO;
    button.layer.borderColor = [[UIColor clearColor]CGColor];
    sender.selected = YES;
    sender.layer.borderColor = [[UIColor whiteColor] CGColor];
    sender.layer.borderWidth = 1.0f;
    self.selectBtnTag = currentTag;
    if ([self.delegate respondsToSelector:@selector(selectColorByCurrentTag:)])
    {
        [self.delegate selectColorByCurrentTag:currentTag];
        
    }
}


@end
