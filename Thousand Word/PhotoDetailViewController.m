//
//  PhotoDetailViewController.m
//  Thousand Word
//
//  Created by delmarz on 1/27/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "Photo.h"
#import "FiltersCollectionViewController.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.imageView.image = self.photo.image;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showFilterCollectionVC"]) {
        if ([segue.destinationViewController isKindOfClass:[FiltersCollectionViewController class]]) {
            FiltersCollectionViewController *filtersCollectionVC = segue.destinationViewController;
            filtersCollectionVC.photo = self.photo;
        }
    }
    
 
}

- (IBAction)addFilterButtonPressed:(UIButton *)sender
{
    
}

- (IBAction)deleteButtonPressed:(UIButton *)sender
{
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    NSError *error = nil;
    
    [[self.photo managedObjectContext] save:&error];
    
    if (error) {
        NSLog(@"error delete button");
    }
    
    [self.navigationController popViewControllerAnimated:true];
        
}
@end
