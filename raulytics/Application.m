//
//  Application.m
//  raulytics
//
//  Created by Administrador on 16/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import "Application.h"

@implementation Application


-(NSString *)description
{
    NSString *sal = [NSString stringWithFormat:@"[%@] %@", self.name, self.appID];
    
    return sal;
}


@end
