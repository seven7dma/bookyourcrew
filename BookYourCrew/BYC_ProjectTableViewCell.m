//
//  BYC_ProjectTableViewCell.m
//  BookYourCrew
//
//  Created by debashisandria on 09/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_ProjectTableViewCell.h"

@implementation BYC_ProjectTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)bookCrewAction:(id)sender {
    
    /*UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"jj" message:self.project_id delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [al show];*/
    [self.delegate didSelectBook:self.project_id];
    
}



@end
