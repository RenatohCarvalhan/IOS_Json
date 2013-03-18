//
//  RubyThreeViewController.m
//  JSON
//
//  Created by Renato Carvalhan on 17/03/13.
//  Copyright (c) 2013 Renato Carvalhan. All rights reserved.
//

#import "RubyThreeViewController.h"
#import "ProfileViewController.h"

@interface RubyThreeViewController () <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
}

@end

@implementation RubyThreeViewController

@synthesize TableView;

/*
 @synthesize cityArray;
 @synthesize imageURLArray;
 @synthesize imageArray;
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Profile";
        self.tabBarItem.image = [UIImage imageNamed:@"111-user.png"];
        
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"RubyThree";
    [[self TableView]setDelegate:self];
    [[self TableView]setDataSource:self];
    array = [[NSMutableArray alloc] init];
    
    NSURL * url =[[NSURL alloc] initWithString:
                  @"http://api.crunchbase.com/v/1/search.js?query=yahoo&api_key=h7dprv5v3gy8frww649v56gy"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection) {
        webData = [[NSMutableData alloc]init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictioray = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSArray *arrayOfName = [allDataDictioray objectForKey:@"results"];
    
    for (NSDictionary *diction in arrayOfName) {
        NSString *label = [diction objectForKey:@"name"];
        
        [array addObject:label];
    }
    [[self TableView]reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}


- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
    
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileViewController *profileVC = [[ProfileViewController alloc]init];
    profileVC.userProfile = self.nameArray[indexPath.row];
    
     profileVC.profileCity = self.cityArray[indexPath.row];
     profileVC.profileImageFile = self.imageArray[indexPath.row];
     profileVC.profileImageURL = self.imageURLArray[indexPath.row];
     
    [self.navigationController pushViewController:profileVC animated:YES];
 
}
 */
@end

