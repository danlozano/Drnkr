//
//  DareViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/20/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "DareViewController.h"

#import "UIColor+DLColor.h"
#import "NSArray+DLRandom.h"


@interface DareViewController ()

@property (nonatomic) PFObject *challenge;

@end

@implementation DareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
        
    [self updateScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Appearance

- (void)updateScreen
{
    self.challenge = [self.challenges randomObject];
    
    if (self.challenge) {
        self.challengeLabel.text = self.challenge[@"text"];
        self.typeLabel.text = [self typeForChallenge: self.challenge];
        self.view.backgroundColor = [UIColor colorForChallenge: self.challenge];
    }else{
        self.challengeLabel.text = @"";
        self.typeLabel.text = @"";
    }
}

#pragma mark - IBAction's

- (IBAction)didSelectShare:(id)sender
{
    NSString *stringToShare = [NSString stringWithFormat: @"Complete el reto: %@ Usando DRNKR App.", self.challengeLabel.text];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems: @[stringToShare]
                                                                             applicationActivities: nil];
    
    activityVC.popoverPresentationController.sourceView = self.shareButton;
    [self presentViewController: activityVC animated: YES completion: nil];
}

- (IBAction)didSelectBack:(id)sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)didSelectOther:(id)sender
{
    [self updateScreen];
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

@end
