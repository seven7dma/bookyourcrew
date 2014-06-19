//
//  BYC_ShowBookedCrewViewController.m
//  BookYourCrew
//
//  Created by Debashis and Ria on 17/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_ShowBookedCrewViewController.h"
#import "constant.h"
#import "BYC_ShowBookedCrewTableViewCell.h"
@interface BYC_ShowBookedCrewViewController ()

@end

@implementation BYC_ShowBookedCrewViewController {
    NSMutableData *_responseData;
    NSArray *projectName, *crewName;
    NSDictionary *json;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@", [user valueForKey:@"empid"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",base_url,@"emp/showData/"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    /*NSString* newStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
     
    NSLog(@"%@",newStr);*/
    
    json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
    
    [self.bookedCrewTab reloadData];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[json valueForKey:@"result"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    
    BYC_ShowBookedCrewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[BYC_ShowBookedCrewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:MyIdentifier];
    }
    
    NSLog(@"%@", [[[json valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"project_name"]);
    
    cell.projectName.text = [[[json valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"project_name"];
    
    cell.crewName.text = [[[json valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"crew_name"];
    
    
    return cell;
    
    
    
}
@end
