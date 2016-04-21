//
//  HelpPage.h
//  PhotoApp
//
//  Created by user on 29/08/13.
//  Copyright (c) 2013 Migital. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MenuClicks;

@interface HelpPage : UIViewController
{
    id <MenuClicks> _currentCanvas;
    
}
@property (nonatomic,strong) id currentCanvas;

@end
