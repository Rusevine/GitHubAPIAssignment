//
//  Repo.m
//  GitHubAPIAssignment
//
//  Created by Wiljay Flores on 2018-08-16.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import "Repo.h"

@implementation Repo

- (instancetype)initWithRepo:(NSDictionary *)repo
{
    self = [super init];
    if (self) {
        _name = repo[@"name"];
    }
    return self;
}

@end
