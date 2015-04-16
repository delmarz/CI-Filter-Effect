//
//  Photo.h
//  Thousand Word
//
//  Created by delmarz on 1/27/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Photo : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Album *albumBook;

@end
