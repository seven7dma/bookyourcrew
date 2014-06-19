//
//  BYC_ProjectTableViewCell.h
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookButtonPressed <NSObject>

-(void)didSelectBook:(NSString *)projectID;

@end

@interface BYC_ProjectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *project_name;

@property (weak, nonatomic) IBOutlet UILabel *production_company;

@property (weak, nonatomic) IBOutlet UILabel *director;

@property (weak, nonatomic) NSString *project_id;

@property(weak, nonatomic) id<BookButtonPressed>delegate;

- (IBAction)bookCrewAction:(id)sender;

@end
