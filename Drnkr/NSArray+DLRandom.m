//
//  NSArray+DLRandom.m
//  Drnkr
//
//  Created by Daniel Lozano on 3/21/15.
//  Copyright (c) 2015 danielozano. All rights reserved.
//

#import "NSArray+DLRandom.h"

@implementation NSArray (DLRandom)

- (id) randomObject
{
    if ([self count] == 0) {
        return nil;
    }
    return [self objectAtIndex: arc4random() % [self count]];
}

@end
