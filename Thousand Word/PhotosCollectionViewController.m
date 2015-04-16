//
//  PhotosCollectionViewController.m
//  Thousand Word
//
//  Created by delmarz on 1/25/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "PhotosCollectionViewCell.h"
#import "PictureDataTransformer.h"
#import "Photo.h"
#import "CoreDataHelper.h"
#import "PhotoDetailViewController.h"

@interface PhotosCollectionViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (strong, nonatomic) NSMutableArray *photos; // Of UIImage

@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"Photo Cell";

-(NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    
    // Do any additional setup after loading the view.
    


     [self.collectionView registerClass:[PhotosCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSSet *unorderedPhotos = self.album.photos;
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:true];
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showPhotoDetailVC"]) {
        if ([segue.destinationViewController isKindOfClass:[PhotoDetailViewController class]]) {
            PhotoDetailViewController *photoDetailVC = segue.destinationViewController;
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
            
            Photo *selectedPhoto = self.photos[indexPath.row];
            photoDetailVC.photo = selectedPhoto;
        }
    }
  
    
}



- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:true completion:nil];
    
    
}


#pragma mark - Helper Methods

-(Photo *)photoFromImage:(UIImage *)image
{
    
    NSManagedObjectContext *context = [CoreDataHelper managedObjectContext];
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.album;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        // error in photoFromImage
        NSLog(@"%@", error);
    }

    
    return photo;
    
}


#pragma mark - UIImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    [self.photos addObject:[self photoFromImage:image]];
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    Photo  *photo = self.photos[indexPath.row];
    
    cell.imageView.image = photo.image;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showPhotoDetailVC" sender:indexPath];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


@end
