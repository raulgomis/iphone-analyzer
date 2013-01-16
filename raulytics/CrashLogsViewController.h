//
//  CrashLogsViewController.h
//  raulytics
//
//  Created by Administrador on 15/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeJSWSManager.h"

@interface CrashLogsViewController : UITableViewController <NodeJSWSManagerDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSMutableArray *crashLogsArray;

@end
