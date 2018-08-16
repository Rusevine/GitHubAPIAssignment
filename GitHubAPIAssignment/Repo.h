//
//  Repo.h
//  GitHubAPIAssignment
//
//  Created by Wiljay Flores on 2018-08-16.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (nonatomic) NSString *name;

-(instancetype)initWithRepo:(NSDictionary *)repo;

@end
