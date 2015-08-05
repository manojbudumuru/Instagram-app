//
//  ClientCalling.h
//  photoTagApp
//
//  Created by Saibersys on 7/20/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageTags.h"
#import "FeedImages.h"
#import "ParsedUserData.h"


@interface ClientCalling : NSObject

+(ClientCalling *) sharedInstance;
-(void)getUserId:(NSString *)userID compleation:(void (^)(id responceObject, NSError *error))compleationBlock;
-(void)getUserFeeds:(NSString *)feeds compleation:(void (^)(id responceObject, NSError *error))compleationBlock;
-(void)getImageData:(NSString *)tagID compleation:(void (^)(id responceObject, NSError *error))compleationBlock;
-(ImageTags *)parsePhotoData:(id)responceObject;
-(ParsedUserData *)parseFeeds:(id)responceObject userName:(NSString *)userName;
-(FeedImages *)parseFeedData:(id)responceObject;
@end
