//
//  ViewController.h
//  photoTagApp
//
//  Created by Saibersys on 7/20/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

- (IBAction)searchBTN:(id)sender;

- (IBAction)feedSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@end

