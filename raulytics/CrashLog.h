//
//  CrashLog.h
//  raulytics
//
//  Created by Administrador on 15/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashLog : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *exception;
@property (strong, nonatomic) NSString *stacktrace;
@property (strong, nonatomic) NSString *appID;


@end
