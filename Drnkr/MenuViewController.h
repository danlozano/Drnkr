//
//  MenuViewController.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate <NSObject>

- (void)menuDidSelectReload;

@end

@interface MenuViewController : UIViewController

@property (weak, nonatomic) id<MenuViewControllerDelegate> delegate;
@property (nonatomic) BOOL dismissModal;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)didSelectClose:(id)sender;
- (IBAction)didSelectReload:(id)sender;

@end
