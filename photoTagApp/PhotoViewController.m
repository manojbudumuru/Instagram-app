//
//  PhotoViewController.m
//  photoTagApp
//
//  Created by Saibersys on 7/20/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import "PhotoViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ViewController.h"


@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.photoCollectionVIew registerNib:[UINib nibWithNibName:@"CoustomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    self.localArray=[[NSMutableArray alloc]initWithArray:self.imageTags.image];
    self.photoCollectionVIew.delegate=self;
    
//    NSLog(@"in collection view viewDidload %lu",self.localArray.count);
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageTags.image.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoustomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSURL * url= [NSURL URLWithString:self.imageTags.image[indexPath.row]];

    [cell.imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    UITapGestureRecognizer *tapOnce=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnce:)];
    UITapGestureRecognizer *tapTwice=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTwice:)];
    tapOnce.numberOfTapsRequired=1;
    tapTwice.numberOfTapsRequired=2;
    [tapOnce requireGestureRecognizerToFail:tapTwice];
    [cell addGestureRecognizer:tapOnce];
    [cell addGestureRecognizer:tapTwice];
    [cell setUserInteractionEnabled:true];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {
    id object = [self.imageTags.image objectAtIndex:fromIndexPath.item];
    [self.imageTags.image removeObjectAtIndex:fromIndexPath.item];
    [self.imageTags.image insertObject:object atIndex:toIndexPath.item];
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {
    
    id object1 = [self.imageTags.image objectAtIndex:fromIndexPath.item];
    id object2 = [self.imageTags.image objectAtIndex:toIndexPath.item];
    object1=object2;
    return YES;
}


-(void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer
{
    [[self photoCollectionVIew] bringSubviewToFront:[gestureRecognizer view]];
    [[gestureRecognizer view] setBounds:CGRectMake(0, 0, 200, 200)];
}

- (void)tapOnce:(UITapGestureRecognizer *)gesture
{
    [[self photoCollectionVIew] addSubview:[gesture view]];
    [[self photoCollectionVIew] bringSubviewToFront:[gesture view]];
    [[gesture view] setBounds:CGRectMake(0, 0, 200, 200)];
}
- (void)tapTwice:(UITapGestureRecognizer *)gesture
{
    [[self photoCollectionVIew] sendSubviewToBack:[gesture view]];
    [[gesture view] setBounds:CGRectMake(0, 0, 100, 100)];
}

-(void)loadMore
{
    
    [self.photoCollectionVIew reloadData];
    
}

-(void)loadMoreIfDown:(NSIndexPath *)indexPath
{
    if (indexPath.row + 3 > self.imageTags.image.count) {
        [self loadMore];
    }
}
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will end drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did end drag");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
