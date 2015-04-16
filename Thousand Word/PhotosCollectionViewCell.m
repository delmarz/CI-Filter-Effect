//
//  PhotosCollectionViewCell.m
//  Thousand Word
//
//  Created by delmarz on 1/25/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "PhotosCollectionViewCell.h"

#define IMAGEVIEW_BORDER_LENGTH 5

@implementation PhotosCollectionViewCell



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
    
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup
{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
    [self.contentView addSubview:self.imageView];
    
}


@end
