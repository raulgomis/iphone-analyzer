//
//  NodeJSWSManager.m
//  raulytics
//
//  Created by Administrador on 15/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import "NodeJSWSManager.h"
#import "CrashLog.h"

@implementation NodeJSWSManager

-(MKNetworkOperation *) getCrashLogs
{
    
    NSLog(@"getCrashLogs");

    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc] init];
    [dicParams setValue:@"test" forKey:@"username"];
    [dicParams setValue:@"test" forKey:@"password"];
    
    MKNetworkOperation *op = [self operationWithPath:@"listCrashLog"
                                              params:dicParams
                                          httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        [self parseCrashLogs:completedOperation.responseData];
    }
    errorHandler:^(MKNetworkOperation* completedRequest, NSError* error) {
        NSLog(@"ERROR....");
    }];
    
    [self enqueueOperation:op];
    
    return op;
}


-(void) parseCrashLogs:(NSData *)data
{
    NSLog(@"parseCrashLogs");
    
    
    NSMutableArray *arrayResults = [[NSMutableArray alloc] init];
    NSError *error;
    NSArray *jsonData = [NSJSONSerialization
                          JSONObjectWithData:data
                          options: kNilOptions
                          error:&error];
    
    
    for (NSDictionary *dic in jsonData){
        CrashLog *crashLog = [[CrashLog alloc] init];
        crashLog.appID = [dic objectForKey:@"applicationId"];
        //crashLog.date = [dic valueForKey:@"date"];
        crashLog.exception = [dic objectForKey:@"exception"];
        crashLog.stacktrace = [dic objectForKey:@"stacktrace"];

        [arrayResults addObject:crashLog];
    }
    
    if ([self.delegate respondsToSelector:@selector(crashLogsFetched:)])
    {
        [self.delegate crashLogsFetched:arrayResults];
    }
     
}


@end
