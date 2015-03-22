//
//  CreateChallengeViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "CreateChallengeViewController.h"

#import <Parse/Parse.h>

@interface CreateChallengeViewController () <UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>

@property (nonatomic) NSArray *typesArray;
@property (nonatomic) NSArray *levelsArray;

@end

@implementation CreateChallengeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.typesArray = @[@"Question", @"Dare"];
    self.levelsArray = @[@"Easy", @"Medium", @"Hard"];
    
    UITapGestureRecognizer *labelTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(hideKeyboard)];
    [self.titleLabel addGestureRecognizer: labelTapRecognizer];
    
    UITapGestureRecognizer *viewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(hideKeyboard)];
    [self.view addGestureRecognizer: viewTapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction's

- (IBAction)didSelectClose:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)didSelectDone:(id)sender
{
    NSString *challengeText = self.challengeTextTextview.text;
    NSString *challengeType = self.typesArray[[self.typePickerView selectedRowInComponent: 0]];
    NSString *challengeLevel = self.levelsArray[[self.levelPickerView selectedRowInComponent: 0]];
    
    if (challengeText.length > 0 && challengeType.length > 0 && challengeLevel.length > 0) {
        
        PFObject *challenge = [PFObject objectWithClassName: @"Challenge"];
        challenge[@"author"] = [PFUser currentUser];
        challenge[@"text"] = challengeText;
        challenge[@"type"] = challengeType;
        challenge[@"level"] = challengeLevel;
        
        [challenge saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (!error) {
                
                if ([self.delegate respondsToSelector: @selector(didCreateChallenge)]) {
                    [self.delegate didCreateChallenge];
                }
                
            }else{
                NSLog(@"ERROR : %@", error);
            }
            
        }];
    }
}

- (void)hideKeyboard
{
    [self.challengeTextTextview resignFirstResponder];
}

#pragma mark - UIPickerView Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.typePickerView) {
        // Type Picker
        return [self.typesArray count];
    }else{
        // Level Picker
        return [self.levelsArray count];
    }
}

#pragma mark - UIPickerView Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel *)view;
    
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont: [UIFont fontWithName: @"Lato-Bold" size: 14]];
        tView.textColor = [UIColor whiteColor];
    }
    
    if (pickerView == self.typePickerView) {
        tView.text = self.typesArray[row];
    }else{
        tView.text = self.levelsArray[row];
    }

    return tView;
}

#pragma mark - UITextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString: @"Challenge text goes here... (Don't forget to add type and level)"]) {
        textView.text = @"";
    }
    return YES;
}

@end
