//
//  PhotosCollectionViewController.h
//  Thousand Word
//
//  Created by delmarz on 1/25/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface PhotosCollectionViewController : UICollectionViewController


@property (strong, nonatomic) Album *album;
- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
