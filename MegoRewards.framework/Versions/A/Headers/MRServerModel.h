
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@protocol MegoRewardServerDataHandller

@optional
-(void)getImage:(UIImage*)downloadedImage;
-(void)serviceSuccessHandller:(NSData*)response;
-(void)servieFailedHandller:(NSString*)errorDescription;
-(void)coinUpdated:(NSDictionary*)response;
-(void)configHandller:(NSDictionary*)response;
-(void)authenticated:(NSString*)tokenKey;
-(void)authenticationServiceSuccessHandller;
-(void)reciveGiftHandler:(NSDictionary*)response;
-(void)sendGiftHandler:(NSDictionary*)response;
-(void)notifyActionHandler:(NSDictionary*)response;
@end


@interface MRServerModel : NSObject
{
    
}

@property (strong, nonatomic) id <MegoRewardServerDataHandller> _delegate;
@property(nonatomic,strong)NSString *appID;
@property(nonatomic,strong)NSString *appSecrate;
@property(nonatomic,strong)NSString *developerID;
@property(nonatomic,strong)NSString *serverPath;
@property(nonatomic,strong)NSString *authenticationServerPath;
@property(nonatomic,strong) NSString *deviceToken;
@property(nonatomic,strong)NSString  *campname;
@property(nonatomic,strong)NSString *minGiftValue;
@property(nonatomic)       int      isAllowGifting;
@property(nonatomic,strong)NSString *rewardID;
@property(nonatomic,strong)NSString *tokenKey;
@property(nonatomic,strong)NSString *appInstallDate;
@property(nonatomic,strong)NSString *dataSavedKey;
@property(nonatomic,strong)NSString *coinBalance;




-(void)fetchCampaigns;
-(void)singleImageDownload:(NSString*)imageUrl;
-(NSMutableArray*)parseInstallShareView:(NSData*)data;
-(void)creditToPurchase;
-(NSString*)getRemainingCoin;
-(void)earnedHistory;
-(void)redeemPoints;
-(void)saveRemainingCoin:(NSString*)usersCoin;
-(void)getPurchasableCoinList;
-(void)updateCointoServer:(NSString*)packageId campaignId:(NSString*)campaignId coins:(NSString*)coins type:(NSString*)type  anotherType:(NSString*)anotherType;
-(void)initializeRewardConfig;
-(void)sendGift:(NSString*)emailId creditsPoints:(NSString*)ceditsPoints;
-(void)receiveGift:(NSString*)promoCode;
-(void)notifyAction:(NSString*)eventId :(NSDictionary*)dicConditions;
-(void)getCreditBalance;
-(NSMutableArray*)parseEarnedHistoryView:(NSData*)data;
-(NSMutableArray*)parseJsonBuyView:(NSData*)data;
-(NSMutableArray*)ParseReadeamedPointsView:(NSData*)data;
+(void)notifyInstallRefferal:(NSString*)refferalDetails;
+(UIImage*)getImageFromBundle:(NSString*)imageName;
-(void)getRewardConfig;
-(void)getCampaigns;
-(void)campaignsData;
-(void)appDataParser:(NSDictionary*)json;
-(void)intializeSDK;




@end
