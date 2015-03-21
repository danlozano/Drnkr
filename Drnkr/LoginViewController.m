//
//  LoginViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "LoginViewController.h"

#import <Parse/Parse.h>

#import "MenuViewController.h"
#import "AccountViewController.h"

@interface LoginViewController () <AccountViewControllerDelegate>

@property (nonatomic) UIActivityIndicatorView *activityView;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeAppearance];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if (self.dismissModal) {
        ((MenuViewController *)self.presentingViewController).dismissModal = YES;
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goToAccount
{
    AccountViewController *accountVC = [self.storyboard instantiateViewControllerWithIdentifier: @"accountViewController"];
    accountVC.delegate = self;
    [self presentViewController: accountVC animated: NO completion: nil];
}

#pragma mark - Appearance

- (void)customizeAppearance
{
    [self setUpActivityIndicatorView];
}

- (void)setUpActivityIndicatorView
{
    self.activityView = [[UIActivityIndicatorView alloc] init];
    self.activityView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    
    [self.view addSubview: self.activityView];
}

#pragma mark - IBAction's

- (IBAction)didSelectLogin:(id)sender
{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (username.length > 0 || password.length > 0) {
        
        [self.activityView startAnimating];
        
        [PFUser logInWithUsernameInBackground: username password: password block:^(PFUser *user, NSError *error) {
            
            if (user) {
                [self goToAccount];
                
            }else{
                NSLog(@"ERROR : LOGIN : %@", error);
            }
            
            [self.activityView stopAnimating];
            
        }];
        
    }else{
        NSLog(@"EMPTY USERNAME OR PASSWORD");
    }
}

- (IBAction)didSelectClose:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - AccountViewController Delegate

- (void)accountDidSelectClose
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
