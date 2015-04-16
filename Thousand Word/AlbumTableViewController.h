//
//  AlbumTableViewController.h
//  Thousand Word
//
//  Created by delmarz on 1/25/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewController : UITableViewController


@property (strong, nonatomic) NSMutableArray *albums;
- (IBAction)addAlbumBarButtonPressed:(UIBarButtonItem *)sender;


@end
