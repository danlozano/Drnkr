//
//  DarePageViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 4/10/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "DarePageViewController.h"

#import "DareViewController.h"
#import "NSArray+DLRandom.h"

@interface DarePageViewController () <UIPageViewControllerDataSource>

@end

@implementation DarePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    
    [self initializePageViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Appearance

- (void)initializePageViewController
{
    DareViewController *dareVC = [self dareViewControllerWithRandomChallenge];
    [self setViewControllers: @[dareVC] direction: UIPageViewControllerNavigationDirectionForward animated: YES completion: nil];
}

#pragma mark - UIPageViewController Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return [self dareViewControllerWithRandomChallenge];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [self dareViewControllerWithRandomChallenge];
}

#pragma mark - Helper's

- (DareViewController *)dareViewControllerWithRandomChallenge
{
    DareViewController *dareVC = [self.storyboard instantiateViewControllerWithIdentifier: @"dareViewController"];
    dareVC.challenge = [self.challenges randomObject];
    return dareVC;
}

@end
