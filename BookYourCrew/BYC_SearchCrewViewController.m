//
//  BYC_SearchCrewViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_SearchCrewViewController.h"
#import "constant.h"
#import "BYC_ShowCrewsViewController.h"
@interface BYC_SearchCrewViewController ()

@end

@implementation BYC_SearchCrewViewController {
    NSDictionary *json;
}
@synthesize fname, lname, lastCompanyWorked;
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
    self.pid.text = self.projectID;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchCrewAction:(id)sender {
    
    NSString *post = [NSString stringWithFormat:@"f_name=%@&last_working_company=%@&l_name=%@",fname.text, lastCompanyWorked.text, lname.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",base_url,@"crew/fetch_from_crew"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];
    
    [self.indc startAnimating];
    [self.view setUserInteractionEnabled:NO];
    
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
    
    NSString* newStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
     
    NSLog(@"%@",newStr);
    
    json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
    
    //NSLog(@"%@",json);
    
    //[self.indc stopAnimating];
    
    if ([[json valueForKey:@"error_code"] isEqualToString:@"1"] || [[json valueForKey:@"error_code"] isEqualToString:@"0"] ) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Error" message:[json valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [al show];
        
        
        [self.indc stopAnimating];
        [self.view setUserInteractionEnabled:YES];
        
        return;
    } else {
        [self performSegueWithIdentifier:@"showcrews" sender:self];
        
    }

    [self.indc stopAnimating];
    [self.view setUserInteractionEnabled:YES];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showcrews"]) {
        BYC_ShowCrewsViewController *showCrews =  [segue destinationViewController];
        showCrews.crews = json;
        showCrews.project_id = self.projectID;
    }
}
@end
