//
//  WebServiceManager.h
//  raulytics
//
//  Created by Administrador on 16/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceManagerDelegate <NSObject>

@optional
-(void) crashLogListReceived:(NSMutableArray *)array;
-(void) applicationListReceived:(NSMutableArray *)array;
-(void) errorDetected;

@end

@interface WebServiceManager : NSObject

@property (strong, nonatomic) id<WebServiceManagerDelegate>delegate;

+ (id)sharedManager;

-(void) loadCrashLogsOfApplication:(NSString *)appID;
-(void) loadApplicationsOfUsername:(NSString *)username;

@end
