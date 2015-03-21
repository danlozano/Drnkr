//
//  MenuViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "MenuViewController.h"

#import <Parse/Parse.h>

#import "AccountViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if (self.dismissModal) {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction's

- (IBAction)didSelectClose:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Motion Shake

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self goToLogin];
    } 
}

- (void)goToLogin
{
    if (![PFUser currentUser]) {
        // Go to login
        [self performSegueWithIdentifier: @"loginSegue" sender: self];
    }else{
        // User is logged in, go to Account
        [self goToAccount];
    }
}

- (void)goToAccount
{
    AccountViewController *accountVC = [self.storyboard instantiateViewControllerWithIdentifier: @"accountViewController"];
    accountVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: accountVC animated: YES completion: nil];
}

@end
