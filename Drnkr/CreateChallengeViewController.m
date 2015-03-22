//
//  CreateChallengeViewController.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "CreateChallengeViewController.h"

#import <Parse/Parse.h>

#import "UIColor+DLColor.h"

@interface CreateChallengeViewController () <UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>

@property (nonatomic) NSArray *typesArrayEsp;
@property (nonatomic) NSArray *levelsArrayEsp;

@property (nonatomic) NSArray *typesArray;
@property (nonatomic) NSArray *levelsArray;

@property (nonatomic) UIActivityIndicatorView *activityView;

@end

@implementation CreateChallengeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.typesArrayEsp = @[@"Pregunta", @"Castigo"];
    self.levelsArrayEsp = @[@"Facil", @"Medio", @"Dificil"];
    
    self.typesArray = @[@"question", @"dare"];
    self.levelsArray = @[@"easy", @"medium", @"hard"];
    
    UITapGestureRecognizer *labelTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(hideKeyboard)];
    [self.titleLabel addGestureRecognizer: labelTapRecognizer];
    
    UITapGestureRecognizer *viewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(hideKeyboard)];
    [self.view addGestureRecognizer: viewTapRecognizer];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    if (self.selectedChallenge) {
        UIColor *backgroundColor = [UIColor colorForChallenge: self.selectedChallenge];
        self.view.backgroundColor = backgroundColor;
        self.challengeTextTextview.backgroundColor = backgroundColor;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if (self.selectedChallenge) {
        // We are editing a challenge.
        self.challengeTextTextview.text = self.selectedChallenge[@"text"];
        [self.typePickerView selectRow: [self.typesArray indexOfObject: self.selectedChallenge[@"type"]] inComponent: 0 animated: YES];
        [self.levelPickerView selectRow: [self.levelsArray indexOfObject: self.selectedChallenge[@"level"]] inComponent: 0 animated: YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [self setUpActivityIndicatorView];
}

#pragma mark - Appearance

- (void)setUpActivityIndicatorView
{
    self.activityView = [[UIActivityIndicatorView alloc] init];
    self.activityView.center = self.doneButton.center;
    
    [self.view addSubview: self.activityView];
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
        
        self.doneButton.hidden = YES;
        [self.activityView startAnimating];
        
        if (!self.selectedChallenge) {
            self.selectedChallenge = [PFObject objectWithClassName: @"Challenge"];
            self.selectedChallenge[@"author"] = [PFUser currentUser];
        }
        self.selectedChallenge[@"text"] = challengeText;
        self.selectedChallenge[@"type"] = challengeType;
        self.selectedChallenge[@"level"] = challengeLevel;
        
        [self.selectedChallenge saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (!error) {
                
                if ([self.delegate respondsToSelector: @selector(didCreateChallenge)]) {
                    [self.delegate didCreateChallenge];
                }
                
            }else{
                NSLog(@"ERROR : %@", error);
            }
            
            [self.activityView stopAnimating];
            self.doneButton.hidden = NO;
            
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
        return [self.typesArrayEsp count];
    }else{
        // Level Picker
        return [self.levelsArrayEsp count];
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
        tView.text = self.typesArrayEsp[row];
    }else{
        tView.text = self.levelsArrayEsp[row];
    }

    return tView;
}

#pragma mark - UITextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString: @"Escribe el texto del reto aqui. (Recuerda escoger nivel y tipo de reto)"]) {
        textView.text = @"";
    }
    return YES;
}

@end
