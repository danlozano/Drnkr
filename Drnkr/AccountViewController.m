//
//  AccountViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "AccountViewController.h"

#import <Parse/Parse.h>

#import "LoginViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction's

- (IBAction)didSelectLogout:(id)sender
{
    [PFUser logOut];
 
    ((LoginViewController *)self.presentingViewController).dismissModal = YES;
    [self dismissViewControllerAnimated: YES completion: nil];
}
- (IBAction)didSelectClose:(id)sender
{
    ((LoginViewController *)self.presentingViewController).dismissModal = YES;
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
