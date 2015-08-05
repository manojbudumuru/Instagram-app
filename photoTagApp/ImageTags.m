//
//  ImageTags.m
//  photoTagApp
//
//  Created by Saibersys on 7/20/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import "ImageTags.h"

@implementation ImageTags

//-(instancetype)init
//{
//   self = [super self];
//    if (self) {
//        
//        _image=self.image;
//        _photoArray=self.photoArray;
//    
//    }
//    return self;
//}

- (NSString *)description
{
    return [NSString stringWithFormat:@"saving in obj file:%lu",(unsigned long)self.image.count];
}
@end
