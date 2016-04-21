
//  NavigateManager.h
//  MegoRewards
//
//  Created by Taylor on 21/03/16.
//
//

#import <UIKit/UIKit.h>


/*!
 @class         NavigateManager
 @brief         The UIViewController class
 @discussion    This class is designed and implemented  for the  User Interface .
 */

@interface MRNavgationController : UIViewController
{
    /*!
     
     @discussion     checks if gifting is enabled or not.
     
     */
    
    BOOL isGiftingEnabled;
}


/*!
 
 @discussion     call this function before calling any other function of Megorewards.
 
 */


-(void)campaign: (UINavigationController *)appNavigationController;



/*!
 
 @discussion    displays the earned history of the user.
 */


-(void)history:(UINavigationController *)appNavigationController;



/*!
 
 @discussion     this will display the send gift box View for gifting credits to another MegoReward user. This function will only work when gifting is enable.
 */


-(void)sedGift:(UINavigationController *)AppNavController;;

/*!
 
 @discussion     displays the receive gift box prompt for receiving gift credits.
 */

-(void)receiveGift;
@end
