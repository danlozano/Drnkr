//
//  AccountViewController.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccountViewControllerDelegate <NSObject>

- (void)accountDidSelectClose;

@end

@interface AccountViewController : UIViewController

@property (weak, nonatomic) id<AccountViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didSelectLogout:(id)sender;
- (IBAction)didSelectClose:(id)sender;

@end
