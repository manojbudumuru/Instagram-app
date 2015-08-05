//
//  FeedCollectionViewController.h
//  photoTagApp
//
//  Created by Saibersys on 8/4/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedImages.h"
#import "ParsedUserData.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LXReorderableCollectionViewFlowLayout.h"

@interface FeedCollectionViewController : UICollectionViewController<LXReorderableCollectionViewDataSource,LXReorderableCollectionViewDelegateFlowLayout>

@property (strong,nonatomic) ParsedUserData * parsed;
@property (strong,nonatomic) FeedImages * feedData;
@property (strong,nonatomic) NSMutableArray * arrayOfFeeds;
@end
