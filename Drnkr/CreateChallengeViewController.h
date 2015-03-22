//
//  CreateChallengeViewController.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateChallengeViewController <NSObject>

- (void)didCreateChallenge;

@end

@interface CreateChallengeViewController : UIViewController

@property (weak, nonatomic) id<CreateChallengeViewController> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *challengeTextTextview;
@property (weak, nonatomic) IBOutlet UIPickerView *typePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *levelPickerView;


- (IBAction)didSelectClose:(id)sender;
- (IBAction)didSelectDone:(id)sender;

@end
