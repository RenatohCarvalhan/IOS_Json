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

@implementation ProfileViewController

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
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                             self.userProfile = JSON;
                                             [self requestSuccessful];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){NSLog(@"%@", error.localizedDescription);}];
    
    [operation start];
}

- (void) requestSuccessful
    {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.scrollView.contentSize = CGSizeMake(320,480);

        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(20,140,280,40);
        nameLabel.text = [NSString stringWithFormat:
                          @"Name: %@", self.userProfile[@"results"][0][@"name"]];
        

        [self.view addSubview:self.scrollView];
        [self.view addSubview:nameLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
