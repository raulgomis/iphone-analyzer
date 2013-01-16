//
//  CrashLogsViewController.m
//  raulytics
//
//  Created by Administrador on 15/01/13.
//  Copyright (c) 2013 eltallerdigital. All rights reserved.
//

#import "CrashLogsViewController.h"
#import "CrashLog.h"

@implementation CrashLogsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"Crash Logs", @"");
    
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];

    
    [self loadCrashLogs];
}

-(void) loadCrashLogs
{
    /*
    NodeJSWSManager *manager = [[NodeJSWSManager alloc] initWithHostName:kBaseWSUrlDev];
    manager.delegate = self;
    [manager getCrashLogs];
    */
    
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000/listCrashLog"]] delegate:self];
    
    [urlConnection start];
}


-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData: %@",  data);
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization
                              JSONObjectWithData:data
                              options: kNilOptions
                              error:&error];
    
    NSArray *arrayCrashes = [jsonData objectForKey:@"listado"];
    for (NSDictionary *dic in arrayCrashes){
        CrashLog *crashLog = [[CrashLog alloc] init];
        crashLog.username = [dic objectForKey:@"username"];
        //crashLog.date = [dic valueForKey:@"date"];
        crashLog.exception = [dic objectForKey:@"exception"];
        crashLog.stacktrace = [dic objectForKey:@"stacktrace"];
        
        [self.crashLogsArray addObject:crashLog];
        
        NSLog(@"eeeee");
    }
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.crashLogsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    CrashLog *crashLog = [self.crashLogsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = crashLog.exception;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - NodeJSManager Delegate

-(void) crashLogsFetched:(NSMutableArray *)crashLogs
{
    self.crashLogsArray = [NSArray arrayWithArray:crashLogs];
    
    [self.tableView reloadData];
}


@end
