//
//  CoreDataHelper.m
//  Thousand Word
//
//  Created by delmarz on 1/27/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "CoreDataHelper.h"
#import "UIKit/UIKit.h"

@implementation CoreDataHelper


+(NSManagedObjectContext *)managedObjectContext
{
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = nil;
    
    if ([delegate managedObjectContext]) {
        context = [delegate managedObjectContext];
    }
    return context;
    
}

@end
