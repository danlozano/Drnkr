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
#import "CreateChallengeViewController.h"
#import "ChallengeTableViewCell.h"
#import "UIColor+DLColor.h"

@interface AccountViewController () <UITableViewDataSource,UITableViewDelegate,CreateChallengeViewController>

@property (nonatomic) NSArray *challenges;

@property (nonatomic) UIActivityIndicatorView *activityView;
@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeAppearance];
    
    [self loadAssets];
    [self.activityView startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network

- (void)loadAssets
{
    PFQuery *userChallengesQuery = [PFQuery queryWithClassName: @"Challenge"];
    [userChallengesQuery whereKey: @"author" equalTo: [PFUser currentUser]];
    [userChallengesQuery orderByDescending: @"createdAt"];
    
    [userChallengesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            self.challenges = objects;
            [self.tableView reloadData];
        }
        
        [self.activityView stopAnimating];
        [self.refreshControl endRefreshing];
        
    }];
}

#pragma mark - Appearance

- (void)customizeAppearance
{
    [self setUpActivityIndicatorView];
    
    self.tableView.estimatedRowHeight = 110.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget: self action: @selector(loadAssets) forControlEvents: UIControlEventValueChanged];
    
    [self.tableView addSubview: self.refreshControl];
}

- (void)setUpActivityIndicatorView
{
    self.activityView = [[UIActivityIndicatorView alloc] init];
    self.activityView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    
    [self.view addSubview: self.activityView];
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.challenges count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"createChallengeCell" forIndexPath: indexPath];
        return cell;
        
    }else{
        
        ChallengeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"challengeCell" forIndexPath: indexPath];
        
        PFObject *challenge = self.challenges[indexPath.row - 1];
        
        cell.challengeTextLabel.text = challenge[@"text"];
        cell.challengeTypeLabel.text = [self typeForChallenge: challenge];
        cell.challengeLevelLabel.text = [self levelForChallenge: challenge];
        
        cell.contentView.backgroundColor = [UIColor colorForChallenge: challenge];
        
        return cell;
        
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateChallengeViewController *createVC = [self.storyboard instantiateViewControllerWithIdentifier: @"createChallengeViewController"];
    createVC.delegate = self;

    if (indexPath.row != 0) {
        // If not first row, so it's editing a challenge, NOT creating
        createVC.selectedChallenge = self.challenges[indexPath.row - 1];
    }
    
    [self presentViewController: createVC animated: YES completion: nil];
    [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
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

#pragma mark - CreateChallengeViewController Delegate

- (void)didCreateChallenge
{
    [self loadAssets];
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Helper's

- (NSString *)typeForChallenge:(PFObject *)challenge
{
    NSString *challengeLevel = challenge[@"type"];
    
    if ([challengeLevel isEqualToString: @"dare"]) {
        return @"Castigo";
        
    }else if([challengeLevel isEqualToString: @"question"]){
        return @"Pregunta";
        
    }else{
        return @"";
        
    }
}

- (NSString *)levelForChallenge:(PFObject *)challenge
{
    NSString *challengeLevel = challenge[@"level"];
    
    if ([challengeLevel isEqualToString: @"easy"]) {
        return @"Facil";
        
    }else if([challengeLevel isEqualToString: @"medium"]){
        return @"Medio";
        
    }else if ([challengeLevel isEqualToString: @"hard"]){
        return @"Dificil";
        
    }else{
        return @"";
    }
}

@end
