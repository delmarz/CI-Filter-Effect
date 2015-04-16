//
//  PictureDataTransformer.m
//  Thousand Word
//
//  Created by delmarz on 1/27/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "PictureDataTransformer.h"
#import "UIKit/UIKit.h"


@implementation PictureDataTransformer


+(Class)transformedValueClass
{
    return [NSData class];
}

+(BOOL)allowsReverseTransformation
{
    return true;
}

-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value
{
    UIImage *image = [UIImage imageWithData:value];
    return image;
}

@end
