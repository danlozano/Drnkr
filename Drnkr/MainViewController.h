//
//  MainViewController.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/20/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *questionsView;
@property (weak, nonatomic) IBOutlet UIView *punishmentsView;

- (IBAction)didSelectMenu:(id)sender;

@end
