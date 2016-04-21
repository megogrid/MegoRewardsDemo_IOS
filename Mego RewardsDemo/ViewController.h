//
//  ViewController.h
//  Mego Shop Demo
//
//  Created by Lalit on 17/12/15.
//  Copyright (c) 2015 unity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideView.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,SlideViewDelegate>

@property (nonatomic , retain) UIImage *chosenImage;
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , strong) NSString *imageName;
@end

