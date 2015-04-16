//
//  CoreDataHelper.h
//  Thousand Word
//
//  Created by delmarz on 1/27/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSManagedObject

+(NSManagedObjectContext *)managedObjectContext;

@end
