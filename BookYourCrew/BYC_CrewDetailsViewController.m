//
//  BYC_CrewDetailsViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 12/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_CrewDetailsViewController.h"
#import "constant.h"
@interface BYC_CrewDetailsViewController ()

@end

@implementation BYC_CrewDetailsViewController {
    NSMutableData *_responseData;
}
@synthesize crew, crewAddress, crewName,crewCountry,crewImage,crewState, crewLastCompanyWorked, crewSkills;
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
    NSLog(@"%@",self.crew);
    
    crewState.text = [crew valueForKey:@"state"];
    crewAddress.text = [crew valueForKey:@"address"];
    crewCountry.text = [crew valueForKey:@"country"];
    
    crewName.text = [NSString stringWithFormat:@"%@ %@", [crew valueForKey:@"f_name"], [crew valueForKey:@"l_name"]];
    
    crewSkills.text = [crew valueForKey:@"skill"];
    crewLastCompanyWorked.text = [crew valueForKey:@"last_working_company"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)bookThisCrew:(id)sender {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //NSLog(@"%@, %@, %@",[crew valueForKey:@"id"], self.project_id, [user valueForKey:@"empid"] );
    
    
    NSString *post = [NSString stringWithFormat:@"emp_id=%@&crew_id=%@&notes=%@&project_id=%@",[user valueForKey:@"empid"],[crew valueForKey:@"id"],@"Booking",self.project_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",base_url,@"emp/insert_booking_emp_crew"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];
    
    [self.indc startAnimating];
    
    
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
    NSString* newStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
     
     NSLog(@"%@",newStr);
    
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
    
    //NSLog(@"%@",json);
    
    //[self.indc stopAnimating];
    
    if (![[json valueForKey:@"error_code"] isEqualToString:@"1"]) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Error" message:[json valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [al show];
        [self.indc stopAnimating];
        return;
    } else if ([[json valueForKey:@"error_code"] isEqualToString:@"1"]) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Success" message:[json valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [al show];
        
        [self.indc stopAnimating];
        
        [self performSegueWithIdentifier:@"backtohome" sender:self];
        
        
    }
    
}
@end
