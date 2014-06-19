//
//  BYC_NewProjectViewController.h
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYC_NewProjectViewController : UIViewController <NSURLConnectionDelegate> {
    NSMutableData *_responseData;
}

@property (weak, nonatomic) IBOutlet UITextField *start_date;

@property (weak, nonatomic) IBOutlet UITextField *end_date;

@property (weak, nonatomic) IBOutlet UITextField *projectName;

@property (weak, nonatomic) IBOutlet UITextField *production_company;

@property (weak, nonatomic) IBOutlet UITextField *director;

@property (weak, nonatomic) IBOutlet UITextField *producer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indc;

- (IBAction)submitNewProjectAction:(id)sender;


@end
