//
//  MainViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/20/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "MainViewController.h"

#import <Parse/Parse.h>

#import "LevelViewController.h"
#import "MenuViewController.h"

@interface MainViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) NSArray *challenges;

@property (nonatomic) NSArray *questionChallenges;
@property (nonatomic) NSArray *dareChallenges;

@property (nonatomic) UIActivityIndicatorView *activityView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeAppearance];
    //[self setUpTapGestureRecognizers];
    
    [self loadAssets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network

- (void)loadAssets
{
    [self.activityView startAnimating];
    
    PFQuery *challengesQuery = [PFQuery queryWithClassName: @"Challenge"];
    [challengesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            self.challenges = objects;
            [self setUpArrays];
            [self setUpTapGestureRecognizers];
            
            [self.activityView stopAnimating];
        }
        
    }];
}

- (void)setUpArrays
{
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    NSMutableArray *dares = [[NSMutableArray alloc] init];
    
    for (PFObject *challenge in self.challenges) {
        if ([challenge[@"type"] isEqualToString: @"question"]) {
            [questions addObject: challenge];
        }else{
            [dares addObject: challenge];
        }
    }
    
    self.questionChallenges = [NSArray arrayWithArray: questions];
    self.dareChallenges = [NSArray arrayWithArray: dares];
}

#pragma mark - Appearance

- (void)customizeAppearance
{
    [self setUpActivityIndicatorView];
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)setUpActivityIndicatorView
{
    self.activityView = [[UIActivityIndicatorView alloc] init];
    self.activityView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    
    [self.view addSubview: self.activityView];
}

- (void)setUpTapGestureRecognizers
{
    UITapGestureRecognizer *questionsTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didSelectQuestions:)];
    UITapGestureRecognizer *daresTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didSelectDares:)];
    
    [self.questionsView addGestureRecognizer: questionsTapRecognizer];
    [self.punishmentsView addGestureRecognizer: daresTapRecognizer];
}

#pragma mark - IBAction's

- (void)didSelectQuestions:(UITapGestureRecognizer *)recognizer
{
    LevelViewController *levelVC = [self.storyboard instantiateViewControllerWithIdentifier: @"levelViewController"];
    levelVC.challenges = self.questionChallenges;
    
    [self.navigationController pushViewController: levelVC animated: YES];
}

- (void)didSelectDares:(UITapGestureRecognizer *)recognizer
{
    LevelViewController *levelVC = [self.storyboard instantiateViewControllerWithIdentifier: @"levelViewController"];
    levelVC.challenges = self.dareChallenges;
    
    [self.navigationController pushViewController: levelVC animated: YES];
}

- (IBAction)didSelectMenu:(id)sender
{
    MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier: @"menuViewController"];
    [self presentViewController: menuVC animated: YES completion: nil];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count > 1) {
        return YES;
    }
    
    return NO;
}

@end
