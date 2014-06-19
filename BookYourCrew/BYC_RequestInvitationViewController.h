//
//  BYC_RequestInvitationViewController.h
//  BookYourCrew
//
//  Created by debashisandria on 27/05/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYC_RequestInvitationViewController : UIViewController <NSURLConnectionDelegate> {
    NSMutableData *_responseData;
}
- (IBAction)inviteAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *msg;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indc;

@end
