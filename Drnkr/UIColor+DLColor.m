//
//  UIColor+DLColor.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "UIColor+DLColor.h"

@implementation UIColor (DLColor)

+ (UIColor *)easyColor
{
    return [UIColor colorWithRed: 238.0/255.0 green: 195.0/255.0 blue: 125.0/255.0 alpha: 1];
}

+ (UIColor *)mediumColor
{
    return [UIColor colorWithRed: 238.0/255.0 green: 139.0/255.0 blue: 125.0/255.0 alpha: 1];
}

+ (UIColor *)hardColor
{
    return [UIColor colorWithRed: 241.0/255.0 green: 106.0/255.0 blue: 106.0/255.0 alpha: 1];
}

@end
