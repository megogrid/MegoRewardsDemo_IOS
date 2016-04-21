//
//  ViewController.m
//  Mego Shop Demo
//
//  Created by Lalit on 17/12/15.
//  Copyright (c) 2015 unity. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ConnectViewController.h"
#import "DownloadImagesHistoryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "HelpPage.h"
#import "FlipRotate.h"
#import "UIImage+Filtering.h"
#import "saveImage.h"
#import "MegoRewards/MRNavgationController.h"




@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    SlideView     *slideViewObj;
    FlipRotate    *flipRotate;
    UIImageView   *cameraImageView;
    UIImageView   *galleryImageView;
    UIView        *ImageFullPreView;
    UIView        *lowerUpperView;
    UIView        *mainView;
    saveImage     *saveimage;
    NSInteger     itemTag;
    MRNavgationController *mRNavgationController ;
    UITextField * alertTextField1;
}

@end

#define DEGREES_TO_RADIANS(x) (x * M_PI/180.0)

@implementation ViewController

@synthesize chosenImage,imageView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    flipRotate=[[FlipRotate alloc]init];
    saveimage= [[saveImage alloc]init];
    
    
    mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    mainView.backgroundColor=[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1];
    [self.view addSubview:mainView];
    
    UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightGesture:)];
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [mainView addGestureRecognizer:swipeRight];
    
    [self headerSection];
    [self loadMainView];
}

#pragma mark - Load Header Section
-(void)headerSection
{
    UIView*headerView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                0,
                                                                self.view.frame.size.width,
                                                                64)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:79/255.0f green:109/255.0f blue:147/255.0f alpha:1]];
    [self.view addSubview:headerView];
    
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                            19,
                                                            self.view.frame.size.width,
                                                            45)];
    [headerView addSubview:navView];
    
    UIButton *sliderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sliderButton setFrame:CGRectMake(15, 17, 22, 15.5)];
    [sliderButton addTarget:self action:@selector(getSlider)forControlEvents:UIControlEventTouchUpInside];
    [sliderButton setBackgroundImage:[UIImage imageNamed:@"Left_menu.png"] forState:UIControlStateNormal];
    [navView addSubview :sliderButton];
    
    UILabel*groupLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0 ,navView.frame.size.width, 45) ];
    groupLabel.text = @"Mego Rewards Demo";
    groupLabel.textAlignment=NSTextAlignmentCenter;
    groupLabel.textColor = [UIColor whiteColor];
    groupLabel.font = [UIFont boldSystemFontOfSize:17];
    [navView addSubview:groupLabel];
    
    UIButton *rightMenu = [[UIButton alloc]initWithFrame:CGRectMake(navView.frame.size.width-20, 15, 4, 15)];
    [rightMenu addTarget:self action:@selector(rightMenuClick)forControlEvents:UIControlEventTouchUpInside];
    [rightMenu setBackgroundImage:[UIImage imageNamed:@"Right_menu.png"] forState:normal ];
    [navView addSubview :rightMenu];
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(navView.frame.size.width-60, 14.5, 16, 16)];
    [searchButton addTarget:self action:@selector(searchButtonClick)forControlEvents:UIControlEventTouchUpInside];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search_icn.png"] forState:normal ];
    [navView addSubview :searchButton];
    
}

#pragma mark - Load Main View
-(void)loadMainView
{
    cameraImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, mainView.frame.size.width-10, 0)];
    cameraImageView.image=[UIImage imageNamed:@"camera_cart.png"];
    cameraImageView.userInteractionEnabled=YES;
    [mainView addSubview:cameraImageView];
    
    UITapGestureRecognizer *cameraImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CameraImageViewClick)];
    cameraImageViewTap.numberOfTapsRequired = 1;
    cameraImageViewTap.delegate=self;
    [cameraImageView addGestureRecognizer:cameraImageViewTap];
    
    galleryImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, mainView.frame.size.height-10, mainView.frame.size.width-10, 0)];
    galleryImageView.image=[UIImage imageNamed:@"Image_cart.png"];
    galleryImageView.tag=2;
    galleryImageView.userInteractionEnabled=YES;
    [mainView addSubview:galleryImageView];
    
    UITapGestureRecognizer *galleryImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(galleryImageViewClick)];
    galleryImageViewTap.numberOfTapsRequired = 1;
    galleryImageViewTap.delegate=self;
    [galleryImageView addGestureRecognizer:galleryImageViewTap];
    
    [UIView animateWithDuration:0.6 animations:^
     {
         cameraImageView.frame=CGRectMake(5, 5, mainView.frame.size.width-10, (mainView.frame.size.height-15)/2);
         galleryImageView.frame=CGRectMake(5, cameraImageView.frame.size.height+10, mainView.frame.size.width-10, (mainView.frame.size.height-30)/2);
     }];
    
}

#pragma mark - Load Image Preview
-(void)loadImageView : (UIImage*)Image
{
    ImageFullPreView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:ImageFullPreView];
    ImageFullPreView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.9];
    
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height-(self.view.frame.size.width))/2-5, self.view.frame.size.width-40, self.view.frame.size.width-40)];
    [ImageFullPreView addSubview:imageView];
    imageView.image=Image;
    
    
    UIView* UpperView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                0,
                                                                self.view.frame.size.width,60)];
    UpperView.backgroundColor =  [UIColor clearColor];
    [ImageFullPreView addSubview:UpperView];
    
    UIButton *cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 15, 30, 30)];
    [UpperView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:normal];
    [cancelButton addTarget:self action:@selector(cancelclick) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:normal];
    
    UIButton *DoneButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 15, 30, 30)];
    [UpperView addSubview:DoneButton];
    [DoneButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:normal];
    [DoneButton addTarget:self action:@selector(doneclick) forControlEvents:UIControlEventTouchUpInside];
    [DoneButton setTitleColor:[UIColor whiteColor] forState:normal];
    
    UIButton *saveButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 15, 30, 30)];
    [UpperView addSubview:saveButton];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:normal];
    [saveButton addTarget:self action:@selector(saveclick) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitleColor:[UIColor whiteColor] forState:normal];
    
    [self lowerButtonsView];
}

#pragma mark - Gesture Recognizer Methods
-(void)swipeRightGesture:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self getSlider];
}

#pragma mark - Header Buttons click
-(void)getSlider
{
    slideViewObj= [[SlideView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    slideViewObj._slideViewDelegate=self;
    [self.view addSubview:slideViewObj];
    
    [UIView animateWithDuration:0.5 animations:^{
        slideViewObj.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    [self.view bringSubviewToFront:slideViewObj];
}

-(void)doneclick
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"ImageType"]isEqualToString:@"camera"])
    {
        cameraImageView.image=imageView.image;
    }
    else
    {
        galleryImageView.image=imageView.image;
    }
    
    [ImageFullPreView removeFromSuperview];
}

-(void)saveclick
{
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Hello!"
                                                     message:@"Do you want to save Image"
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:@"Cancel", nil];
    alert.tag=99;
    [alert show];
}

-(void)cancelclick
{
    [ImageFullPreView removeFromSuperview];
}

-(void)searchButtonClick
{
    
}

-(void)rightMenuClick
{
    
}

#pragma mark - To Open Camera or Gallery
-(void)CameraImageViewClick
{
    if ([self isSameImage:[UIImage imageNamed:@"camera_cart.png"] imageView1:cameraImageView])
    {
        NSLog(@"Same");
    }
    [[NSUserDefaults standardUserDefaults]setValue:@"camera" forKey:@"ImageType"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self CameraCalling];
}

-(void)galleryImageViewClick
{
    if ([self isSameImage:[UIImage imageNamed: @"gallery_cart.png"] imageView1:galleryImageView])
    {
        NSLog(@"Same");
    }
    [[NSUserDefaults standardUserDefaults]setValue:@"gallery" forKey:@"ImageType"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self GalleryCalling];
}

-(void)CameraCalling
{
    if([UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront] ||
       [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Oops"
                                    message:@"Device has no Camera"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

-(void)GalleryCalling
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Image Picker Delegates
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    chosenImage = info[UIImagePickerControllerEditedImage];
    [self loadImageView:chosenImage];
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        self.imageName = [representation filename];
        NSLog(@"fileName : %@",self.imageName);
    };
    
    ALAssetsLibrary* assetslibrary = [[[ALAssetsLibrary alloc] init] autorelease];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)PushToViewController:(long)indexPath
{
    mRNavgationController=[[MRNavgationController alloc]init];
    
    if (indexPath==0)
    {
        [ mRNavgationController campaign:(self.navigationController)];
        
    }
    
    
     if (indexPath==1)
    {
        [ mRNavgationController history:(self.navigationController)];

    
    }
    
     if (indexPath==2)
     {
         [ mRNavgationController sedGift:(self.navigationController)];

    }
    
    if (indexPath==3)
    {
        [mRNavgationController receiveGift];

    }

}



#pragma mark - Lower Main Category Buttons View
-(void)lowerButtonsView
{
    UIView*lowerView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                               self.view.frame.size.height-60,
                                                               self.view.frame.size.width,60)];
    
    [ImageFullPreView addSubview:lowerView];
    
    NSArray*buttonPic = [[NSArray alloc] initWithObjects:@"flip_s.png",@"rotate.png" ,@"enahance.png",nil];
    
    NSArray*buttonname = [[NSArray alloc] initWithObjects:@"Flip",@"Rotate" ,@"Enahance",nil];
    
    int xpos = 75;
    
    for(int i = 0; i<3; i++)
    {
        UIButton*button = [[UIButton alloc]initWithFrame:CGRectMake(xpos,5, 35, 35)];
        
        button.backgroundColor=[UIColor clearColor];
        
        button.tag = i+1;
        
        [button setImage:[UIImage imageNamed:[buttonPic objectAtIndex:i]] forState:UIControlStateNormal];
        
        [button setTitle:[buttonname objectAtIndex:i] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lowerView addSubview:button];
        [button addTarget:self action:@selector(clicksActionButtons:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(55.0, -90.0, 5.0, -20.0)];
        xpos = xpos +button.frame.size.width*2*1;
    }
}

#pragma mark - Lower Main Category Buttons Click
-(void)clicksActionButtons:(UIButton*)sender
{
    itemTag = sender.tag;
    if (itemTag==1)
    {
        [self flip];
        
    }else if(itemTag==2)
    {
        [self rotate];
    }
    else if(itemTag==3)
    {
        [self enahanceButtons];
    }
}

#pragma mark - Lower Subcategory Buttons View
-(void)enahanceButtons
{
    [lowerUpperView removeFromSuperview];
    lowerUpperView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-122, self.view.frame.size.width,60)];
    lowerUpperView.userInteractionEnabled = YES;
    
    lowerUpperView.layer.opacity = 0.5;
    lowerUpperView.layer.transform = CATransform3DMakeScale(1, 1, 1.0);
    
    
    [UIView animateWithDuration:0.50f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         lowerUpperView.layer.opacity = 1.0f;
                         lowerUpperView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
    
    
    [ImageFullPreView addSubview:lowerUpperView];
    NSArray*buttonname=[[NSArray alloc] initWithObjects:@"Bright",@"Contrast" ,@"Sharpness",@"Sepia",@"Invert",nil];
    
    int xpos = 30;
    for(int i = 0; i<5; i++)
    {
        
        UIButton *actionbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        actionbutton.frame=CGRectMake(xpos,5, 35, 35);
        actionbutton.backgroundColor=[UIColor clearColor];
        
        
        [actionbutton setImage:[UIImage imageNamed:@"round_se.png"] forState:UIControlStateNormal];
        
        [lowerUpperView addSubview:actionbutton];
        
        [actionbutton addTarget:self action:@selector(enahanceClick:) forControlEvents:UIControlEventTouchUpInside];
        
        actionbutton.titleLabel.font=[UIFont systemFontOfSize:10];
        [actionbutton setTitle:[buttonname objectAtIndex:i]forState:UIControlStateNormal];
        
        [actionbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        actionbutton.tag = i+1;
        
        [actionbutton setTitleEdgeInsets:UIEdgeInsetsMake(55.0, -90.0, 5.0, -20.0)];
        xpos=xpos +actionbutton.frame.size.width*1.6;
    }
}

-(void)rotate
{
    [lowerUpperView removeFromSuperview];
    lowerUpperView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-122, self.view.frame.size.width,60)];
    lowerUpperView.userInteractionEnabled = YES;
    
    lowerUpperView.layer.opacity = 0.5;
    lowerUpperView.layer.transform = CATransform3DMakeScale(1, 1, 1.0);
    
    
    [UIView animateWithDuration:0.50f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         lowerUpperView.layer.opacity = 1.0f;
                         lowerUpperView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
    
    
    [ImageFullPreView addSubview:lowerUpperView];
    
    lowerUpperView.backgroundColor=[UIColor clearColor];
    
    UIButton *clock=[[UIButton alloc]initWithFrame:CGRectMake(80,5,35,35)];
    clock.tag=1;
    [clock setBackgroundImage:[UIImage imageNamed:@"edit_rotate_thumb_1.png"] forState:UIControlStateNormal];
    [clock addTarget:self action:@selector(ClocknadAnti:) forControlEvents:UIControlEventTouchUpInside];
    clock.backgroundColor=[UIColor clearColor];
    [lowerUpperView addSubview:clock];
    
    [clock setTitle:@"Clockwise" forState:UIControlStateNormal];
    clock.titleLabel.font=[UIFont systemFontOfSize:10];
    [clock setTitleColor:[UIColor colorWithRed:0.28 green: 0.46 blue:0.46 alpha:1] forState:UIControlStateNormal];
    [clock setTitleEdgeInsets:UIEdgeInsetsMake(55.0, -90.0, 5.0, -90.0)];
    
    UIButton *anti=[[UIButton alloc]initWithFrame:CGRectMake(200,5,35,35)];
    anti.tag=2;
    [anti setBackgroundImage:[UIImage imageNamed:@"edit_rotate_thumb_0.png"] forState:UIControlStateNormal];
    [anti addTarget:self action:@selector(ClocknadAnti:) forControlEvents:UIControlEventTouchUpInside];
    anti.backgroundColor=[UIColor clearColor];
    [lowerUpperView addSubview:anti];
    
    [anti setTitle:@"Counter Clockwise" forState:UIControlStateNormal];
    anti.titleLabel.font=[UIFont systemFontOfSize:10];
    [anti setTitleColor:[UIColor colorWithRed:0.28 green: 0.46 blue:0.46 alpha:1] forState:UIControlStateNormal];
    [anti setTitleEdgeInsets:UIEdgeInsetsMake(55.0, -90.0, 5.0, -90.0)];
}

-(void)flip
{
    [lowerUpperView removeFromSuperview];
    lowerUpperView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-122, self.view.frame.size.width,60)];
    lowerUpperView.userInteractionEnabled = YES;
    lowerUpperView.layer.opacity = 0.5;
    lowerUpperView.layer.transform = CATransform3DMakeScale(1, 1, 1.0);
    
    
    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         lowerUpperView.layer.opacity = 1.0f;
                         lowerUpperView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
    
    
    [ImageFullPreView addSubview:lowerUpperView];
    
    UIButton *hor=[[UIButton alloc]initWithFrame:CGRectMake(80,5,35,35)];
    hor.tag=1;
    [hor addTarget:self action:@selector(HorandVarti:) forControlEvents:UIControlEventTouchUpInside];
    [hor setBackgroundImage:[UIImage imageNamed:@"edit_flip_thumb_1.png"] forState:UIControlStateNormal];
    [lowerUpperView addSubview:hor];
    
    [hor setTitle:@"Horizontal" forState:UIControlStateNormal];
    hor.titleLabel.font=[UIFont systemFontOfSize:10];
    [hor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hor setTitleEdgeInsets:UIEdgeInsetsMake(55.0, -90.0, 5.0, -90.0)];
    
    UIButton *var=[[UIButton alloc]initWithFrame:CGRectMake(200,5,35,35)];
    var.tag=2;
    [var addTarget:self action:@selector(HorandVarti:) forControlEvents:UIControlEventTouchUpInside];
    [var setBackgroundImage:[UIImage imageNamed:@"edit_flip_thumb_0.png"] forState:UIControlStateNormal];
    [lowerUpperView addSubview:var];
    
    [var setTitle:@"Vertical" forState:UIControlStateNormal];
    var.titleLabel.font=[UIFont systemFontOfSize:10];
    [var setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [var setTitleEdgeInsets:UIEdgeInsetsMake(55.0, -90.0, 5.0, -90.0)];
}

#pragma mark - Lower Subcategory Buttons Click
-(void)enahanceClick:(UIButton*)sender
{
    NSLog(@"sender===>%ld",(long)sender.tag);
    
    switch (sender.tag)
    {
        case 1:
            [self brigtness_Effect];
            break;
        case 2:
            [self contrast_Effect];
            break;
        case 3:
            [self sharpness_Effect];
            break;
        case 4:
            [self sepia_Effect];
            break;
        case 5:
            [self invert_Effect];
            break;
    }
}

-(void)HorandVarti:(UIButton*)sender
{
    if(sender.tag==1)
    {
        [flipRotate FlipVertical:imageView];
        
    }
    if(sender.tag==2)
    {
        [flipRotate FlipHorizontal:imageView];
    }
    
    
}

-(void)ClocknadAnti:(UIButton*)sender
{
    if(sender.tag==1)
    {
        [self Rotate:(-90)];
    }
    if(sender.tag==2)
    {
        [self Rotate:90];
    }
}

-(void)Rotate:(CGFloat)angle
{
    CGImageRef imageRef = [flipRotate CGImageRotatedByAngle: [imageView.image CGImage] angle:angle];
    UIImage* img = [UIImage imageWithCGImage: imageRef];
    chosenImage = img;
    
    CGFloat radians = atan2f(imageView.transform.b, imageView.transform.a);
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         imageView.transform = CGAffineTransformMakeRotation(radians+DEGREES_TO_RADIANS(angle));
                     }
                     completion:nil];
}

- (BOOL)isSameImage : (UIImage *)imageName imageView1:(UIImageView *)imageView1
{
    UIImage*temp= imageView1.image;
    UIImage*temp2= imageName;
    
    NSData *data1 = UIImagePNGRepresentation(temp);
    NSData *data2 = UIImagePNGRepresentation(temp2);
    
    return [data1 isEqual:data2];
}


#pragma mark Enahance Effect Implemantation

-(void) brigtness_Effect
{
    imageView.image =[imageView.image brightenWithValue:20];
}

-(void)contrast_Effect
{
    imageView.image=[imageView.image contrastAdjustmentWithValue:20];
}

-(void)sharpness_Effect
{
    imageView.image =[imageView.image sharpenWithBias:0.0];
}

-(void)sepia_Effect
{
    imageView.image = [imageView.image gammaCorrectionWithValue:0.2];
}

-(void)invert_Effect
{
    imageView.image = [imageView.image embossWithBias:0.2];
}


#pragma mark - AlertView Button Click
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==99)
    {
        if (buttonIndex == 0)
        {
            [saveimage saveImage:imageView.image];
            [self SaveImageInNSUserDefaults];
        }
        if (buttonIndex == 1)
        {
            
        }
    }
}


-(void)SaveImageInNSUserDefaults
{
    NSMutableArray *ImagesDescriptionArray=[[NSMutableArray alloc]init];
    [ImagesDescriptionArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"meUserImageArray"]];
    
    NSDate *Date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:Date];
    
    [dateFormatter setDateFormat:@"dd/MMM/YYYY"];
    NSString *currentDate = [dateFormatter stringFromDate:Date];
    [dateFormatter release];
    
    NSMutableDictionary *ImageDataDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                       self.imageName,@"imageName",
                                       currentDate,@"imageDate",
                                       currentTime,@"imageTime",
                                       nil];
    [ImagesDescriptionArray addObject:ImageDataDic];
    
    [[NSUserDefaults standardUserDefaults]setObject:ImagesDescriptionArray forKey:@"meUserImageArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
