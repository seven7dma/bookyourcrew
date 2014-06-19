//
//  BYC_SearchCrewViewController.h
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYC_SearchCrewViewController : UIViewController <NSURLConnectionDelegate>{
    
     NSMutableData *_responseData;
    
}
@property (nonatomic, weak) NSString *projectID;


@property (weak, nonatomic) IBOutlet UILabel *pid;

@property (weak, nonatomic) IBOutlet UITextField *fname;

@property (weak, nonatomic) IBOutlet UITextField *lname;

@property (weak, nonatomic) IBOutlet UITextField *lastCompanyWorked;

- (IBAction)searchCrewAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indc;


@end
