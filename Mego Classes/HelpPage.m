//
//  HelpPage.m
//  PhotoApp
//
//  Created by user on 29/08/13.
//  Copyright (c) 2013 Migital. All rights reserved.
//

#import "HelpPage.h"

@interface HelpPage ()

@end

@implementation HelpPage
UIImageView *logoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =YES;
    [self tempData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


-(void)tempData
{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,60)];
    headerView.backgroundColor=[UIColor colorWithRed:0.28 green: 0.46 blue:0.46 alpha:1];
    [ self.view addSubview:headerView];
    
    UIButton *BackButtonClick=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
    BackButtonClick.backgroundColor=[UIColor  colorWithRed:0.28 green: 0.46 blue:0.46 alpha:1];
    [BackButtonClick addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
    [ headerView addSubview:BackButtonClick];
    
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0,17,40,40)];
    [logoView setImage:[UIImage imageNamed:@"goBack_un.png"]];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    [BackButtonClick addSubview:logoView];
    
    UIImageView *logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 20, 32, 32)];
    [logoImgView setImage:[UIImage imageNamed:@"photo-magig-icon.png"]];
    [headerView addSubview:logoImgView];
    
    UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake(80,20, 150, 30)];
    [l1 setBackgroundColor:[UIColor clearColor]];
    l1.text=  @"Photo Magix";
    l1.font=[UIFont fontWithName:@"AmericanTypewriter" size:20];
    l1.textColor=[UIColor whiteColor];
    [headerView addSubview:l1];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,90, self.view.frame.size.width, 899)];
    
    UIColor *bckgrndcolour = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [scrollView setBackgroundColor:bckgrndcolour];
    [self.view addSubview:scrollView];
    
    

    
    UILabel *Lbl=[[UILabel alloc]initWithFrame:CGRectMake(100,60,100,30)];
    Lbl.text=@"HELP";
    Lbl.font=[UIFont fontWithName:@"AmericanTypewriter" size:20];
    Lbl.backgroundColor=[UIColor clearColor];
    [self.view addSubview:Lbl];
    Lbl.textAlignment = NSTextAlignmentCenter;
    
    
    NSArray *colorAry = [NSArray arrayWithObjects:
                         @"*Tap on the Photo Magix icon to launch the App.",
                         
                         @"*REGISTRATION-",
                         
                         @"1.Become a register user to create your permanent",@"account on the app!",
                         
                         @"2.You can register using either your Facebook  ",@"account or seprate Email ID!",
                         @"3.Tab on My Accouny section to complete the  ",@"personalized detail which will be used for providing ",@"updates/packs as per your perferences ",
                         
                        @"*MY GALLERY- All the pics of your gallery are shown" ,@" in the \"My Gallery\" tab and the pics that have been",@" edited using this app are saved in \"MY Effect\" tab",
                         
                         @"*INTERNET- The app uses the internet to get photos",
                         @" from your Facebook after you sync in your account",@" details Facebook not only shows your images ",@" but of your Friends as well.",
                         
                         @"*EFFECT- Select from various effects including Tattoo,",
                         @"Ghost, Paper, Nature, Hair",
                         
                         @"*EDITING- Edit you images using options like Rotate,",
                         @" Flip, Re-size and Crop.",
                         
                         @"*TEXT- Enhance your pics with feature to add text",
                         @"in a Dialogue Bubble or Text Fields format.",
                         
                         @"*CLIPART- Add various clip art images to your pics ",
                         @"for a different look.",
                         
                         @"*ARTIST- Draw free hand images on any selected or",
                         @"  a blank canvas. You can directly",
                         
                         @"*GRID- Option given on the bottom bar allows access",
                         @" to varied types of ",
                         
                         @"*Collages- (Magix grid,Magix mix,Shape Collage)",
                         @",FB Collage Outline(Broder & Farme) and ",
                         @"Greetings(Festival & Mood Greetings)",
                         
                         @"*SAVE- Use the option give on the top rigth side ",
                         @"to save edited image",
                         
                         @"*SHARE-.You can also share your edited pics easily via",
                         @" Message or an Email.",
                         
                         @"*RESET- Use the Reset icon given on the right hand side ",
                         @" to remove the effect and reset the image to its normal look.",
                         
                         @"*CART- You can easily download more packs  and items to  ",
                         @"beautiy pics using the shopping cart",
                         
                        nil];
    
    int ypos = 0;
    for(int i=0;i<[colorAry count];i++)
    {
//        UILabel *TextLbl = [CCV label:CGRectMake(10, ypos, 100, 768) BackColor:[UIColor clearColor] LblText:[colorAry objectAtIndex:i] TextColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0] FontSize:30.0f Alignment:'L' parentView:nil];
        
        UILabel *TextLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, ypos,self.view.frame.size.width,100)];
        TextLbl.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0];
        [scrollView addSubview:TextLbl];
        TextLbl.text=[colorAry objectAtIndex:i];
        ypos = ypos+35;
        
        
    }
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, ypos+100)];
    
    
    
}


- (IBAction)gotoBack
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc
{
    
}


@end
