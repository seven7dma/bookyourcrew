//
//  BYC_ShowCrewsViewController.m
//  BookYourCrew
//
//  Created by debashisandria on 12/06/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "BYC_ShowCrewsViewController.h"
#import "ShowCrewsTableViewCell.h"
#import "BYC_CrewDetailsViewController.h"
@interface BYC_ShowCrewsViewController ()

@end

@implementation BYC_ShowCrewsViewController {
    NSArray *crewName;
    NSArray *crewAddress;
    NSArray *crewIDs;
    NSArray *crewPhoneNumber;
}
@synthesize crews;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[crews valueForKey:@"result"] count];    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    
    ShowCrewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[ShowCrewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:MyIdentifier];
    }
    
    cell.crewName.text = [NSString stringWithFormat:@"%@ %@", [[[crews valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"f_name"],[[[crews valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"l_name"]];
    
    cell.crewAddress.text = [[[crews valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"address"];
    
    cell.crewPhoneNumber.text = [[[crews valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"phone_no"];
    
    return cell;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Assume self.view is the table view
    NSIndexPath *path = [self.crewTab indexPathForSelectedRow];
    
    if ([[segue identifier] isEqualToString:@"bookcrew"]) {
        BYC_CrewDetailsViewController *det = (BYC_CrewDetailsViewController *)[segue destinationViewController];
        
        det.crew = [[crews valueForKey:@"result"] objectAtIndex:path.row];
        det.project_id = self.project_id;
    }
    
    
}

@end
