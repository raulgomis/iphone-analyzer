//
//  ApplicationsViewController.h
//  raulytics
//
//  Created by Administrador on 16/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceManager.h"

@interface ApplicationsViewController : UITableViewController <WebServiceManagerDelegate,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *applicationsArray;

@end
