//
//  BYC_HomeViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 27/05/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_HomeViewController.h"

@interface BYC_HomeViewController ()

@end

@implementation BYC_HomeViewController

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
    [self.navigationController setNavigationBarHidden:YES];
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnEmployerAction:(id)sender {
    
    [self performSegueWithIdentifier:@"emplogin" sender:self];
    
}
@end
