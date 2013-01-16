//
//  WebServiceManager.m
//  raulytics
//
//  Created by Administrador on 16/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import "WebServiceManager.h"
#import "CrashLog.h"
#import "Application.h"

@implementation WebServiceManager

+ (id)sharedManager {
    static WebServiceManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

#pragma mark - Crash Log Methods
-(void) loadCrashLogsOfApplication:(NSString *)appID
{
        
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/listCrashLog/%@", kBaseWSUrlDev, appID]];
    
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:url];
    //[request setHTTPMethod:@"GET"];
    /*
     NSString *postString = @"company=Locassa&quality=AWESOME!";
     [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
     */
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error != nil)
         {
             if ([self.delegate respondsToSelector:@selector(errorDetected)]){
                 [self.delegate errorDetected];
             }
         }
         else {
             [self receivedCrashLogsData:data];
         }
         
     }];
    
}

- (void)receivedCrashLogsData:(NSData *)data
{    
    
    NSMutableArray *crashLogsArray = [[NSMutableArray alloc] init];
    
    NSString* newStr = [[NSString alloc] initWithData:data                                              encoding:NSUTF8StringEncoding];
    NSLog(@"receivedCrashLogsData: %@", newStr);
    
    NSError *error;
    NSArray *arrayParsed = [NSJSONSerialization
                             JSONObjectWithData:data
                             options: NSJSONReadingMutableContainers
                             error:&error];
    
    
    for (NSDictionary *dic in arrayParsed){
        CrashLog *crashLog = [[CrashLog alloc] init];
        crashLog.appID = [dic objectForKey:@"applicationId"];
        crashLog.date = nil;
        crashLog.exception = [dic objectForKey:@"exception"];
        crashLog.stacktrace = [dic objectForKey:@"stacktrace"];
        
        if ([dic objectForKey:@"exception"] != nil && [dic objectForKey:@"applicationId"] != nil){
            [crashLogsArray addObject:crashLog];
            NSLog(@"%@", crashLog);

        }
        
    }
    
    
    if ([self.delegate respondsToSelector:@selector(crashLogListReceived:)])
    {
        [self.delegate crashLogListReceived:crashLogsArray];
    }
        
    
}

#pragma mark - Application List Methods
-(void) loadApplicationsOfUsername:(NSString *)username
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/listApplications/%@", kBaseWSUrlDev, username]];
    
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:url];
    //[request setHTTPMethod:@"GET"];
    /*
     NSString *postString = @"company=Locassa&quality=AWESOME!";
     [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
     */
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error != nil)
         {
             if ([self.delegate respondsToSelector:@selector(errorDetected)]){
                 [self.delegate errorDetected];
             }
         }
         else {
             [self receivedApplicationsData:data];
         }
         
     }];
    
}

- (void)receivedApplicationsData:(NSData *)data
{
    
    NSMutableArray *applicationsArray = [[NSMutableArray alloc] init];
    
    NSString* newStr = [[NSString alloc] initWithData:data                                              encoding:NSUTF8StringEncoding];
    NSLog(@"receivedApplicationsData: %@", newStr);
    
    NSError *error;
    NSArray *arrayParsed = [NSJSONSerialization
                             JSONObjectWithData:data
                             options: NSJSONReadingMutableContainers
                             error:&error];
    
    
    for (NSDictionary *dic in arrayParsed){
        Application *app = [[Application alloc] init];
        app.name = [dic objectForKey:@"name"];
        app.appID = [dic objectForKey:@"applicationId"];
        app.date = nil;
        
        [applicationsArray addObject:app];
        
        NSLog(@"%@", app);
    }
    
    
    if ([self.delegate respondsToSelector:@selector(applicationListReceived:)])
    {
        [self.delegate applicationListReceived:applicationsArray];
    }
    
    
}

@end
