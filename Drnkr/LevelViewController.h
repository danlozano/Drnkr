//
//  LevelViewController.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/20/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LevelViewController : UIViewController

@property (nonatomic) NSArray *challenges;

@property (weak, nonatomic) IBOutlet UIView *easyView;
@property (weak, nonatomic) IBOutlet UIView *mediumView;
@property (weak, nonatomic) IBOutlet UIView *hardView;

- (IBAction)didSelectBack:(id)sender;

@end
