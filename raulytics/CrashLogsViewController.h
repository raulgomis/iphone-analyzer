//
//  CrashLogsViewController.h
//  raulytics
//
//  Created by Administrador on 15/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceManager.h"
#import "Application.h"

@interface CrashLogsViewController : UITableViewController <WebServiceManagerDelegate>

@property (strong, nonatomic) NSMutableArray *crashLogsArray;
@property (strong, nonatomic) Application *application;

@end
