//
//  CoustomeCollectionViewCell.m
//  photoTagApp
//
//  Created by Saibersys on 7/22/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import "CoustomeCollectionViewCell.h"

@implementation CoustomeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setUp];
}
-(void)setUp
{
    self.layer.borderColor=(__bridge CGColorRef)([UIColor blueColor]);
}
@end
