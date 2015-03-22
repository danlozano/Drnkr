//
//  ChallengeTableViewCell.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *challengeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *challengeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *challengeLevelLabel;

@end
