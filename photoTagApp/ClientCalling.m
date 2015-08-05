//
//  ClientCalling.m
//  photoTagApp
//
//  Created by Saibersys on 7/20/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import "ClientCalling.h"
#import <AFNetworking/AFNetworking.h>
#define KCLIENTID @"de3a9c8895ef461bbaf0fab33e3f38fa"
#define KBASEURL @"https://api.instagram.com/v1/"
#define KFEEDSSUFIX @"/media/recent?"
#define KSUFFFIX @"/media/recent/?"
#define KPREFIX @"users/"
#define KUSERSUFFIX @"users/search?"
#define KTAGURL @"tags/"

@interface ClientCalling()

@property (strong,nonatomic) AFHTTPSessionManager * httpSessionManager;

@end
@implementation ClientCalling

+(ClientCalling *)sharedInstance
{
    static ClientCalling * firstInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        firstInstance=[[ClientCalling alloc]init];
    });
    return firstInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.httpSessionManager= [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KBASEURL]];
    }
    return self;
}

//retriving image data from https://api.instagram.com/v1/tags/{tag-name}/media/recent?access_token=ACCESS-TOKEN

-(void)getImageData:(NSString *)tagID compleation:(void (^)(id responceObject, NSError *error))compleationBlock
{
    
    NSString * url = [NSString stringWithFormat:@"%@%@%@%@",KBASEURL,KTAGURL,tagID,KFEEDSSUFIX];
    
    NSDictionary * dict = @{@"client_id" : KCLIENTID};
    
    [self.httpSessionManager GET: url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (compleationBlock) {
            compleationBlock(responseObject,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (compleationBlock) {
            compleationBlock(nil,error);
        }
        
    }];

}
//parsing data for photo tag

-(ImageTags *)parsePhotoData:(id)responceObject
{
    BOOL value = false;
    ImageTags * userValues =[[ImageTags alloc]init];
    NSDictionary * userdictionary = responceObject;
    
    if ([userdictionary isKindOfClass:[NSDictionary class]]) {
        value=true;
        NSArray * photoArrayNew = userdictionary[@"data"];
        if ([photoArrayNew isKindOfClass:[NSArray class]]) {
//             NSLog(@"%lu",(unsigned long)photoArrayNew.count);
            userValues.photoArray=photoArrayNew;
//            NSLog(@"%@",photoArrayNew);
    }
}
    userValues.image=[[NSMutableArray alloc]init];
    for (int i=0; i<userValues.photoArray.count; i++) {
        [userValues.image addObject:userValues.photoArray[i][@"images"][@"standard_resolution"][@"url"]];
        [userValues.image addObject:userValues.photoArray[i][@"images"][@"low_resolution"][@"url"]];
        [userValues.image addObject:userValues.photoArray[i][@"images"][@"thumbnail"][@"url"]];
    }
//    NSLog(@"in parsing method %lu",(unsigned long)userValues.image.count);
    
    return value ? userValues:nil;
}

// retriving data from https://api.instagram.com/v1/users/search?q=jack&access_token=ACCESS-TOKEN
-(void)getUserId:(NSString *)userID compleation:(void (^)(id responceObject, NSError *error))compleationBlock
{
    NSString * url= [NSString stringWithFormat:@"%@%@",KBASEURL,KUSERSUFFIX];
    NSDictionary * dict = @{@"q" : userID, @"client_id" : KCLIENTID};
    [self.httpSessionManager GET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if (compleationBlock) {
            compleationBlock(responseObject,nil);
        }
//        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (compleationBlock) {
            compleationBlock(nil,error);
        }
    }];
    
    
}

//Retriving User feeds From https://api.instagram.com/v1/users/{user-id}/media/recent/?access_token=ACCESS-TOKEN

-(void)getUserFeeds:(NSString *)feeds compleation:(void (^)(id responceObject, NSError *error))compleationBlock
{
    NSString * url= [NSString stringWithFormat:@"%@%@%@%@",KBASEURL,KPREFIX,feeds,KSUFFFIX];
    NSDictionary * dict = @{@"client_id" : KCLIENTID};
    [self.httpSessionManager GET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if (compleationBlock) {
            compleationBlock(responseObject,nil);
        }
//        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (compleationBlock) {
            compleationBlock(nil,error);
        }
    }];
}

// parsing of username

-(ParsedUserData *)parseFeeds:(id)responceObject userName:(NSString *)userName
{
    BOOL value=false;
    ParsedUserData * userValues =[[ParsedUserData alloc]init];
    NSDictionary * userdictionary = responceObject;
    if ([userdictionary isKindOfClass:[NSDictionary class]]) {
        NSArray * nameArray = userdictionary[@"data"];
        for (NSDictionary * dict in nameArray) {
            NSString * user= dict[@"username"];
            if ([userName isEqualToString:user]) {
                value = true;
                userValues.userName=dict[@"username"];
                userValues.userId=dict[@"id"];
                userValues.profilePic=dict[@"profile_picture"];
                break;
            }
        }
        
    }

    return value ? userValues : nil;
}

// parsing user feeds data
-(FeedImages *)parseFeedData:(id)responceObject{
    BOOL value = false;
    FeedImages * userValues =[[FeedImages alloc]init];
    NSDictionary * userdictionary = responceObject;
    if ([userdictionary isKindOfClass:[NSDictionary class]]) {
        NSArray * photoArrayNew = userdictionary[@"data"];
        if ([photoArrayNew isKindOfClass:[NSArray class]]) {
            value=true;
            userValues.feedPhotoArray=photoArrayNew;
        }
    }
    userValues.feedImage=[[NSMutableArray alloc]init];
    for (int i=0; i<userValues.feedPhotoArray.count; i++) {
        [userValues.feedImage addObject:userValues.feedPhotoArray[i][@"images"][@"standard_resolution"][@"url"]];
    }
    
    return value ? userValues:nil;
}
@end
