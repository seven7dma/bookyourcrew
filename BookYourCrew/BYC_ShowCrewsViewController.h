//
//  BYC_ShowCrewsViewController.h
//  BookYourCrew
//
//  Created by debashisandria on 12/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYC_ShowCrewsViewController : UIViewController
@property (nonatomic, weak) NSDictionary *crews;
@property (nonatomic, weak) NSString *project_id;
@property (weak, nonatomic) IBOutlet UITableView *crewTab;

@end
