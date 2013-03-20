//
//  ProfileViewController.m
//  JSON
//
//  Created by Renato Carvalhan on 17/03/13.
//  Copyright (c) 2013 Renato Carvalhan. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFJSONRequestOperation.h"
#import "RubyThreeViewController.h"

@implementation ProfileViewController
NSMutableData *webData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Profile";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
       
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://api.crunchbase.com/v/1/search.js?query=yahoo&api_key=h7dprv5v3gy8frww649v56gy"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    RubyThreeViewController *RubyController = [[RubyThreeViewController alloc] init];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
{
    RubyController.Transf = self.userProfile;
    [self requestSuccessful];
}
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
{
    NSLog(@"%@", error.localizedDescription);}];
    
    [operation start];
}

- (void) requestSuccessful
    {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.scrollView.contentSize = CGSizeMake(320,480);
        
        NSString *nameJSON = [self.userProfile objectForKey:@"name"];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(20,140,280,40);
        nameLabel.text = [NSString stringWithFormat:@"Name: %@", nameJSON];
        [self.scrollView addSubview:nameLabel];
        
        NSString *overviewJSON = [self.userProfile objectForKey:@"overview"];
        UITextView *overviewLabel = [[UITextView alloc] initWithFrame:CGRectMake(12,260,300,180)];
        overviewLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        overviewLabel.editable = NO;
        overviewLabel.text = [NSString stringWithFormat:@"OverView: %@", overviewJSON];
        [self.scrollView addSubview:overviewLabel];
        
        [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
