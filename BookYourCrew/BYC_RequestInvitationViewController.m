//
//  BYC_RequestInvitationViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 27/05/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_RequestInvitationViewController.h"

@interface BYC_RequestInvitationViewController ()

@end

@implementation BYC_RequestInvitationViewController
@synthesize phone, email, msg;
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
    [self.navigationController setNavigationBarHidden:NO];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];

}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    [phone resignFirstResponder];
    [email resignFirstResponder];
    [msg resignFirstResponder];
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

- (IBAction)inviteAction:(id)sender {
    
    
    if ([phone.text rangeOfString:@"+"].location == NSNotFound) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter a valid phone number with area code starting with + sign" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [al show];
        
        return;
    }
    
    NSString *phoneNumber = [phone.text stringByReplacingOccurrencesOfString:@"+"
                                         withString:@"%2B"];
    
    
    NSString *post = [NSString stringWithFormat:@"name=%@&phone=%@&email=%@", msg.text, phoneNumber, email.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://digicrazers.com/sourav/byc/api/index.php/crew/request_sms"]];
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
    //NSString* newStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",newStr);
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
    
    NSLog(@"%@",json);
    
    [self.indc stopAnimating];
    
    if (![[json valueForKey:@"error_code"] isEqualToString:@"0"]) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Error" message:[json valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [al show];
        
        return;
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
