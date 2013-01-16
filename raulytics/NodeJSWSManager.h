//
//  NodeJSWSManager.h
//  raulytics
//
//  Created by Administrador on 15/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

@protocol NodeJSWSManagerDelegate <NSObject>

-(void) crashLogsFetched:(NSMutableArray *)crashLogs;

@end


@interface NodeJSWSManager : MKNetworkEngine

@property (strong, nonatomic) id<NodeJSWSManagerDelegate> delegate;

-(MKNetworkOperation *) getCrashLogs;


@end
