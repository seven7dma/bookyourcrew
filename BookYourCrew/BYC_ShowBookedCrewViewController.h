//
//  BYC_ShowBookedCrewViewController.h
//  BookYourCrew
//
//  Created by Debashis and Ria on 17/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYC_ShowBookedCrewViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *bookedCrewTab;

@end
