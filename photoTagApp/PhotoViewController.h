//
//  PhotoViewController.h
//  photoTagApp
//
//  Created by Saibersys on 7/20/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXReorderableCollectionViewFlowLayout.h"
#import "ImageTags.h"
#import "CoustomeCollectionViewCell.h"

@interface PhotoViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,LXReorderableCollectionViewDataSource,LXReorderableCollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionVIew;


@property (strong,nonatomic) NSMutableArray * localArray;
@property (strong,nonatomic) ImageTags * imageTags;

@end
