//
//  NJContatc.m
//  01-私人通讯录
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NJContatc.h"

@implementation NJContatc

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phoneNumber forKey:@"number"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"number"];
    }
    return self;
}

@end
