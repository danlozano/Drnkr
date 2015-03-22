//
//  LevelViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/20/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "LevelViewController.h"

#import "DareViewController.h"

@interface LevelViewController ()

@property (nonatomic) NSArray *easyChallenges;
@property (nonatomic) NSArray *mediumChallenges;
@property (nonatomic) NSArray *hardChallenges;

@end

@implementation LevelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self customizeAppearance];
    [self setUpTapGestureRecognizers];
    
    [self setUpArrays];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpArrays
{
    NSMutableArray *easyChallenges = [[NSMutableArray alloc] init];
    NSMutableArray *mediumChallenges = [[NSMutableArray alloc] init];
    NSMutableArray *hardChallenges = [[NSMutableArray alloc] init];
    
    for (PFObject *challenge in self.challenges) {
        if ([challenge[@"level"] isEqualToString: @"easy"]) {
            [easyChallenges addObject: challenge];
            
        }else if([challenge[@"level"] isEqualToString: @"medium"]){
            [mediumChallenges addObject: challenge];
            
        }else{
            [hardChallenges addObject: challenge];
        }
    }
    
    self.easyChallenges = [NSArray arrayWithArray: easyChallenges];
    self.mediumChallenges = [NSArray arrayWithArray: mediumChallenges];
    self.hardChallenges = [NSArray arrayWithArray: hardChallenges];
    
}

#pragma mark - Appearance

- (void)customizeAppearance
{

}

- (void)setUpTapGestureRecognizers
{
    UITapGestureRecognizer *easyTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didSelectEasy:)];
    UITapGestureRecognizer *mediumTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didSelectMedium:)];
    UITapGestureRecognizer *hardTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didSelectHard:)];
    
    [self.easyView addGestureRecognizer: easyTapRecognizer];
    [self.mediumView addGestureRecognizer: mediumTapRecognizer];
    [self.hardView addGestureRecognizer: hardTapRecognizer];
}

#pragma mark - IBAction's

- (void)didSelectEasy:(UITapGestureRecognizer *)recognizer
{
    DareViewController *dareVC = [self.storyboard instantiateViewControllerWithIdentifier: @"dareViewController"];
    dareVC.challenges = self.easyChallenges;
    
    [self.navigationController pushViewController: dareVC animated: YES];
}

- (void)didSelectMedium:(UITapGestureRecognizer *)recognizer
{
    DareViewController *dareVC = [self.storyboard instantiateViewControllerWithIdentifier: @"dareViewController"];
    dareVC.challenges = self.mediumChallenges;
    
    [self.navigationController pushViewController: dareVC animated: YES];

}

- (void)didSelectHard:(UITapGestureRecognizer *)recognizer
{
    DareViewController *dareVC = [self.storyboard instantiateViewControllerWithIdentifier: @"dareViewController"];
    dareVC.challenges = self.hardChallenges;
    
    [self.navigationController pushViewController: dareVC animated: YES];

}

- (IBAction)didSelectBack:(id)sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

@end
