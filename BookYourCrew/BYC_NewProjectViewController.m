//
//  BYC_NewProjectViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_NewProjectViewController.h"
#import "constant.h"
@interface BYC_NewProjectViewController ()

@end

@implementation BYC_NewProjectViewController
@synthesize start_date, end_date, projectName, production_company, producer, director;
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
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    start_date.inputView = datePicker;
    
    
    UIDatePicker *datePicker1 = [[UIDatePicker alloc] init];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(datePickerValueChanged1:) forControlEvents:UIControlEventValueChanged];
    end_date.inputView = datePicker1;
    
    
    
    
}

-(void)datePickerValueChanged:(UIDatePicker*)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/YYYY"];
    start_date.text = [NSString stringWithFormat:@"%@",[df stringFromDate:sender.date]];
}

-(void)datePickerValueChanged1:(UIDatePicker*)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/YYYY"];
    end_date.text = [NSString stringWithFormat:@"%@",[df stringFromDate:sender.date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitNewProjectAction:(id)sender {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *post = [NSString stringWithFormat:@"user_id=%@&project_name=%@&production_company=%@&director=%@&producer=%@&start_date=%@&end_date=%@",[user valueForKey:@"empid"], projectName.text, production_company.text, director.text, producer.text, start_date.text, end_date.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",base_url,@"crew/project_insert"]]];
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
    
    /*NSString* newStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",newStr);*/
    
    [self.indc stopAnimating];
    [self.view setUserInteractionEnabled:YES];
    
    [self performSegueWithIdentifier:@"projectcreated" sender:self];
    
}
@end
