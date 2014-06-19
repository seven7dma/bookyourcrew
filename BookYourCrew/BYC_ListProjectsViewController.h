//
//  BYC_ListProjectsViewController.h
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYC_ProjectTableViewCell.h"
#import "constant.h"
#import "BYC_SearchCrewViewController.h"
@interface BYC_ListProjectsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, BookButtonPressed> {
    
    NSMutableData *_responseData;
   
}
@property (weak, nonatomic) IBOutlet UITableView *projectTab;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indc;


@end
