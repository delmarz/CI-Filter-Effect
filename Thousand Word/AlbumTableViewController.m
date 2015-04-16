//
//  AlbumTableViewController.m
//  Thousand Word
//
//  Created by delmarz on 1/25/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "AlbumTableViewController.h"
#import "Album.h"
#import "CoreDataHelper.h"
#import "PhotosCollectionViewController.h"


@interface AlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation AlbumTableViewController

-(NSMutableArray *)albums
{
    if (!_albums) {
        _albums = [[NSMutableArray alloc] init];
    }
    return _albums;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    NSSortDescriptor  *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:true];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
 
    NSManagedObjectContext *context = [CoreDataHelper managedObjectContext];
    
    NSError *error = nil;
    
    NSArray *fetchedAlbum = [context executeFetchRequest:fetchRequest error:&error];
    
    self.albums = [fetchedAlbum mutableCopy];
                             
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAlbumBarButtonPressed:(UIBarButtonItem *)sender
{
    
    UIAlertView *albumAlertView = [[UIAlertView alloc] initWithTitle:@"Add new Album name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [albumAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [albumAlertView show];

}


#pragma mark - Helper Methods

-(Album *)albumWithName:(NSString *)name
{
    
    
    NSManagedObjectContext *context = [CoreDataHelper managedObjectContext];
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        //we have an error
        NSLog(@"%@", error);
    }
    return album;
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 1) {
        NSString *alertText = [alertView textFieldAtIndex:0].text;
        [self.albums addObject:[self albumWithName:alertText]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.albums count] -1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    Album *album = self.albums[indexPath.row];
    
    cell.textLabel.text = album.name;
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showPhotoCollectionVC"])
    {
        if ([segue.destinationViewController isKindOfClass:[PhotosCollectionViewController class]]) {
            PhotosCollectionViewController *photoCollectionVC = segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            Album *selectedAlbum = self.albums[indexPath.row];
            
            photoCollectionVC.album = selectedAlbum;
        }
        
        
        
    }
    
    
    
}



@end
