//
//  DareViewController.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/20/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DareViewController : UIViewController

@property (nonatomic) NSArray *challenges;

@property (weak, nonatomic) IBOutlet UILabel *challengeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction)didSelectShare:(id)sender;
- (IBAction)didSelectBack:(id)sender;
- (IBAction)didSelectOther:(id)sender;


@end
