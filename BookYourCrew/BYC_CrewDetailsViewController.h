//
//  BYC_CrewDetailsViewController.h
//  BookYourCrew
//
//  Created by debashisandria on 12/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYC_CrewDetailsViewController : UIViewController
@property (nonatomic, weak) NSDictionary *crew;
@property (nonatomic, weak) NSString *project_id;
@property (weak, nonatomic) IBOutlet UIImageView *crewImage;

@property (weak, nonatomic) IBOutlet UILabel *crewName;

@property (weak, nonatomic) IBOutlet UILabel *crewAddress;

@property (weak, nonatomic) IBOutlet UILabel *crewCountry;

@property (weak, nonatomic) IBOutlet UILabel *crewState;

@property (weak, nonatomic) IBOutlet UILabel *crewLastCompanyWorked;

@property (weak, nonatomic) IBOutlet UILabel *crewSkills;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indc;


- (IBAction)bookThisCrew:(id)sender;
@end
