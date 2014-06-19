//
//  BYC_ListProjectsViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_ListProjectsViewController.h"

@interface BYC_ListProjectsViewController ()

@end

@implementation BYC_ListProjectsViewController {
    NSArray *projectNames, *productionCompanies, *directors, *projectIDs;
    
    NSString *selectedProjectID;
}
@synthesize projectTab;
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
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *post = [NSString stringWithFormat:@"user_id=%@",[user valueForKey:@"empid"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",base_url,@"emp/showData"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];
    
    [self.indc startAnimating];
    [self.view setUserInteractionEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return projectNames.count;    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    
    BYC_ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[BYC_ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    cell.project_name.text = [projectNames objectAtIndex:indexPath.row];
    cell.production_company.text = [productionCompanies objectAtIndex:indexPath.row];
    cell.director.text = [directors objectAtIndex:indexPath.row];
    cell.project_id = [projectIDs objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
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
    
    /*NSString* newStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",newStr);*/
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
    
    projectNames = [[NSArray alloc]initWithArray:[json valueForKey:@"project_name"]];
    productionCompanies = [[NSArray alloc]initWithArray:[json valueForKey:@"production_company"]];
    directors = [[NSArray alloc]initWithArray:[json valueForKey:@"director"]];
    projectIDs = [[NSArray alloc]initWithArray:[json valueForKey:@"project_id"]];
    
    [projectTab reloadData];
    
    [self.indc stopAnimating];
    [self.view setUserInteractionEnabled:YES];
    
}

-(void)didSelectBook:(NSString *)projectID {
      selectedProjectID = projectID;
    [self performSegueWithIdentifier:@"bookcrew" sender:self];
    
  
     

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"bookcrew"]) {
        BYC_SearchCrewViewController *searchCrew = (BYC_SearchCrewViewController *)[segue destinationViewController];
        
        searchCrew.projectID = selectedProjectID;
    }
}

@end
