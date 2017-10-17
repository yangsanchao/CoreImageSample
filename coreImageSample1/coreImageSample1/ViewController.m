//
//  ViewController.m
//  coreImageSample1
//
//  Created by yangsc on 2017/10/10.
//  Copyright © 2017年 com.baofengcloud. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@property(nonatomic,retain)UISlider * slider;
@property(nonatomic,retain)UIImage * image;
@property(nonatomic,retain)UIImageView * imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _image = [UIImage imageNamed:@"1.jpeg"];
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width * 9 / 16);
    _imageView = [[UIImageView alloc]initWithFrame:frame];
    _imageView.userInteractionEnabled = YES;
    [_imageView setImage:_image];
    [self.view addSubview:_imageView];
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.2,400,self.view.frame.size.width * 0.6,30)];
    _slider.maximumValue = 1.0;
    _slider.minimumValue = 0;
    _slider.continuous = YES;
    [_slider addTarget:self action:@selector(valueChange)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
}

-(void)valueChange {
    //旧色调
    [self filterSepiaTone];
}

//旧色调处理
-(void)filterSepiaTone
{
    //创建CIContext
    CIContext * context = [CIContext contextWithOptions:nil];
    //获取图片
    CIImage *cimage = [CIImage imageWithCGImage:[_image CGImage]];
    //创建CIFilter
    CIFilter * sepiaTone = [CIFilter filterWithName:@"CISepiaTone"];
    //设置滤镜输入参数
    [sepiaTone setValue:cimage forKey:@"inputImage"];
    
    //设置色调强度
    [sepiaTone setValue:[NSNumber numberWithFloat:[_slider value]]forKey:@"inputIntensity"];
    
    //创建处理后的图片
    CIImage * resultImage = [sepiaTone valueForKey:@"outputImage"];
    CGImageRef imageRef = [context createCGImage:resultImage fromRect:CGRectMake(0,0,self.image.size.width,self.image.size.height)];
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    [_imageView setImage:image];
    CFRelease(imageRef);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
