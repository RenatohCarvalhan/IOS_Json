//
//  ProfileViewController.h
//  JSON
//
//  Created by Renato Carvalhan on 17/03/13.
//  Copyright (c) 2013 Renato Carvalhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSDictionary *userProfile;


- (void) requestSuccessful;
@end
