//
//  ParsedUserData.m
//  photoTagApp
//
//  Created by Saibersys on 8/4/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import "ParsedUserData.h"

@implementation ParsedUserData

- (NSString *)description
{
    return [NSString stringWithFormat:@"user details: %@,%@,%@",self.userId,self.userName,self.profilePic];
}

@end
