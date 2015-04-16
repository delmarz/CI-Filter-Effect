//
//  PhotoDetailViewController.h
//  Thousand Word
//
//  Created by delmarz on 1/27/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;
@interface PhotoDetailViewController : UIViewController

@property (strong, nonatomic) Photo *photo;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deleteButtonPressed:(UIButton *)sender;


@end
