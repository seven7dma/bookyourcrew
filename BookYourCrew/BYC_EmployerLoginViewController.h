//
//  BYC_EmployerLoginViewController.h
//  BookYourCrew
//
//  Created by debashisandria on 30/05/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYC_EmployerLoginViewController : UIViewController <NSURLConnectionDelegate> {
    NSMutableData *_responseData;
}
@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indc;


- (IBAction)btnLoginAction:(id)sender;


@end
