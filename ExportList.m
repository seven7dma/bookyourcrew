//
//  ExportList.m
//  BookYourCrew
//
//  Created by Amrita on 19/05/14.
//  Copyright (c) 2014 Digi Crazers. All rights reserved.
//

#import "ExportList.h"
#import "ExportListCell.h"
@interface ExportList ()

@end

@implementation ExportList

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
	// Do any additional setup after loading the view.
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExportListCell *exportListCell =[tableView dequeueReusableCellWithIdentifier:@"ExportListCell" forIndexPath:indexPath];
   
  
    return exportListCell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
