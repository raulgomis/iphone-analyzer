//
//  CrashLog.m
//  raulytics
//
//  Created by Administrador on 15/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import "CrashLog.h"

@implementation CrashLog

-(NSString *)description
{
    NSString *sal = [NSString stringWithFormat:@"[%@] %@", self.username, self.exception];
    
    return sal;
}

@end
