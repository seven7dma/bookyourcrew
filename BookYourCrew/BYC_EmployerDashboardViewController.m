//
//  BYC_EmployerDashboardViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 30/05/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_EmployerDashboardViewController.h"

@interface BYC_EmployerDashboardViewController ()

@end

@implementation BYC_EmployerDashboardViewController
@synthesize empname;
@synthesize email;
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
    empname.text = [user valueForKey:@"empname"];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
