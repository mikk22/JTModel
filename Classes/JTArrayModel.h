//
//  JTArrayModel.h
//  Jeetrium
//
//  Created by Mihail Koltsov on 5/16/12.
//  Copyright (c) 2012 Intelvision. All rights reserved.
//

#import "JTBaseModel.h"

@interface JTArrayModel : JTBaseModel
{
    NSArray                     *_dataObjects;
}

@property (nonatomic, readonly)     NSArray                     *dataObjects;

-(void)addObject:(id)object;
-(void)removeObjectAtIndex:(NSUInteger)index;
-(void)insertObject:(id)anObject AtIndex:(NSUInteger)index;
-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
-(void)replaceObject:(id)anObject withObject:(id)newObject;


@end
