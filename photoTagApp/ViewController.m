//
//  ViewController.m
//  photoTagApp
//
//  Created by Saibersys on 7/20/15.
//  Copyright (c) 2015 Saibersys. All rights reserved.
//

#import "ViewController.h"
#import "ClientCalling.h"
#import "PhotoViewController.h"
#import "ImageTags.h"
#import "FeedImages.h"
#import "ParsedUserData.h"
#import "FeedCollectionViewController.h"


@interface ViewController ()
@property(strong,nonatomic) ImageTags * images;
@property(strong,nonatomic) FeedImages * feedImag;
@property(strong,nonatomic) ParsedUserData * parsedData;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.images=[[ImageTags alloc]init];
    self.feedImag=[[FeedImages alloc]init];
//    self.parsedData=[[ParsedUserData alloc]init];
//    NSLog(@"in viewdidload: %lu",self.images.image.count);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    NSLog(@"in viewWillAppear: %lu",self.images.image.count);

    
}

// loading the url and adding the subview of UIWebView

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchBTN:(id)sender {
    
    NSString * str = @"selfie";
    [[ClientCalling sharedInstance]getImageData:str compleation:^(id responceObject, NSError *error) {
        if (!error) {
            
            self.images=[[ClientCalling sharedInstance]parsePhotoData:responceObject];
//            NSLog(@"%@",self.images);
            [self performSegueWithIdentifier:@"seg" sender:self];
            
            
        }
        else{
            UIAlertView * alert = [[UIAlertView alloc]
                                   initWithTitle:@"Error"
                                   message:@"no internet"
                                   delegate:self
                                   cancelButtonTitle:@"ok"
                                   otherButtonTitles:nil,
                                   nil];
            [alert show];
        }
    }];
   
}

- (IBAction)feedSearch:(id)sender {
    if (self.searchText.text.length==0) {
        UIAlertView * alert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                               message:@"Please enter user name"
                               delegate:self
                               cancelButtonTitle:@"ok"
                               otherButtonTitles:nil,
                               nil];
        [alert show];
    }
    else
    {
        NSString * feed= self.searchText.text;
        [[ClientCalling sharedInstance]getUserId:feed compleation:^(id responceObject, NSError *error) {
            if (!error) {
                self.parsedData=[[ClientCalling sharedInstance]parseFeeds:responceObject userName:self.searchText.text];
                [[ClientCalling sharedInstance]getUserFeeds:self.parsedData.userId compleation:^(id responceObject, NSError *error) {
                    if (!error) {
                        self.feedImag=[[ClientCalling sharedInstance]parseFeedData:responceObject];
                        if ([self shouldPerformSegueWithIdentifier:@"seg2" sender:self]) {
                            [self performSegueWithIdentifier:@"seg2" sender:self];
                        }
                        NSLog(@"%@",self.feedImag.feedImage);
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]
                                               initWithTitle:@"Error"
                                               message:@"error again"
                                               delegate:self
                                               cancelButtonTitle:@"ok"
                                               otherButtonTitles:nil,
                                               nil];
                        [alert show];
                    }
                }];
   
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]
                                       initWithTitle:@"Error"
                                       message:@"no internet"
                                       delegate:self
                                       cancelButtonTitle:@"ok"
                                       otherButtonTitles:nil,
                                       nil];
                [alert show];
            }
        }];
    }
    
}


 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier  isEqualToString:@"seg"]) {
         PhotoViewController *pc=[segue destinationViewController];
         pc.imageTags=self.images;
     }
     else if ([segue.identifier isEqualToString:@"seg2"])
     {
         FeedCollectionViewController * fc=[segue destinationViewController];
         fc.parsed=self.parsedData;
         fc.feedData=self.feedImag;
     }
 }

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"seg2"] && !self.parsedData) {
        UIAlertView * alert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                               message:@"Cannot find the user with the user name you entered."
                               delegate:self
                               cancelButtonTitle:@"ok"
                               otherButtonTitles:nil,
                               nil];
        [alert show];
        return NO;
    }
    return YES;
}

@end
