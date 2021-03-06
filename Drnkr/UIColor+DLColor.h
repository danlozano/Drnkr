//
//  UIColor+DLColor.h
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface UIColor (DLColor)

+ (UIColor *)easyColor;
+ (UIColor *)mediumColor;
+ (UIColor *)hardColor;
+ (UIColor *)colorForChallenge:(PFObject *)challenge;

@end
