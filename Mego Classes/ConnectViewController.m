//
//  ConnectViewController.m
//  Mego Shop Demo
//
//  Created by ankit-iphone on 2/12/16.
//  Copyright (c) 2016 unity. All rights reserved.
//

#import "ConnectViewController.h"

@interface ConnectViewController ()
{
    UIView *mainView;
}

@end

@implementation ConnectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    mainView.backgroundColor=[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1];
    [self.view addSubview:mainView];
    
    [self headerSection];
    [self loadMainView];
    
}

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
    groupLabel.text = @"Connect";
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

-(void)loadMainView
{
    UIImageView *FacebookView=[[UIImageView alloc]initWithFrame:CGRectMake(8, 10, self.view.frame.size.width-16, (self.view.frame.size.height-64)/3-15)];
    FacebookView.image=[UIImage imageNamed:@"facebookscreen_card.png"];
    [mainView addSubview:FacebookView];
    
    UIImageView *emailView=[[UIImageView alloc]initWithFrame:CGRectMake(8, FacebookView.frame.size.height+20, self.view.frame.size.width-16, (self.view.frame.size.height-64)/3-15)];
    emailView.image=[UIImage imageNamed:@"facebookscreen_card.png"];
    [mainView addSubview:emailView];
    
    UIImageView *PhoneNumberView=[[UIImageView alloc]initWithFrame:CGRectMake(8, emailView.frame.origin.y+emailView.frame.size.height+10, self.view.frame.size.width-16, (self.view.frame.size.height-64)/3-15)];
    PhoneNumberView.image=[UIImage imageNamed:@"facebookscreen_card.png"];
    [mainView addSubview:PhoneNumberView];
    
    UIButton *fb=[[UIButton alloc]initWithFrame:CGRectMake((FacebookView.frame.size.width/3)/2-10, (FacebookView.frame.size.height-30)/2-10, FacebookView.frame.size.width/3, 30)];
    [fb setImage:[UIImage imageNamed:@"facebook.png"] forState:normal];
    [fb addTarget:self action:@selector(faceBookButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [FacebookView addSubview:fb];
    
    UIButton *google=[[UIButton alloc]initWithFrame:CGRectMake(fb.frame.origin.x+fb.frame.size.width+20, (FacebookView.frame.size.height-30)/2-10, FacebookView.frame.size.width/3, 30)];
    [google setImage:[UIImage imageNamed:@"google+.png"] forState:normal];
    [google addTarget:self action:@selector(googleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [FacebookView addSubview:google];
    
    
    UIButton *email=[[UIButton alloc]initWithFrame:CGRectMake(FacebookView.frame.size.width/3, (FacebookView.frame.size.height-30)/2-10, FacebookView.frame.size.width/3, 30)];
    [email setImage:[UIImage imageNamed:@"email.png"] forState:normal];
    [email addTarget:self action:@selector(emailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [emailView addSubview:email];
    
    UIButton *phoneNo=[[UIButton alloc]initWithFrame:CGRectMake(FacebookView.frame.size.width/3, (FacebookView.frame.size.height-30)/2-10, FacebookView.frame.size.width/3, 30)];
    [phoneNo setImage:[UIImage imageNamed:@"phone_No.png"] forState:normal];
    [phoneNo addTarget:self action:@selector(phoneNoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [PhoneNumberView addSubview:phoneNo];
    
    UILabel *fbLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, fb.frame.origin.y+fb.frame.size.height+10, FacebookView.frame.size.width, 20)];
    [FacebookView addSubview:fbLabel];
    fbLabel.text=@"Connect With Facebook, Google";
    fbLabel.font=[UIFont systemFontOfSize:12];
    fbLabel.textAlignment=NSTextAlignmentCenter;
    
    UILabel *emailLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, fb.frame.origin.y+fb.frame.size.height+10, FacebookView.frame.size.width, 20)];
    [emailView addSubview:emailLabel];
    emailLabel.text=@"Connect With Your Email";
    emailLabel.font=[UIFont systemFontOfSize:12];
    emailLabel.textAlignment=NSTextAlignmentCenter;
    
    UILabel *phnLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, fb.frame.origin.y+fb.frame.size.height+10, FacebookView.frame.size.width, 20)];
    [PhoneNumberView addSubview:phnLabel];
    phnLabel.text=@"Connect With Personal Number";
    phnLabel.font=[UIFont systemFontOfSize:12];
    phnLabel.textAlignment=NSTextAlignmentCenter;
    
}

#pragma mark - Header Buttons Click
-(void)getSlider
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)searchButtonClick
{
    
}

-(void)rightMenuClick
{
    
}

#pragma mark - Social Buttons Click
-(void)faceBookButtonClick
{
    
}

-(void)googleButtonClick
{
    
}

-(void)emailButtonClick
{
    
}

-(void)phoneNoButtonClick
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
