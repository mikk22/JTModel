//
//  JTArrayModel.h
//
//
//  Created by mikk.22 on 5/16/12.
//  Copyright (c) 2012 mikk.22. All rights reserved.
//

#import "JTModel.h"

@interface JTArrayModel : JTModel

@property (nonatomic, readonly)     NSArray     *dataObjects;

-(void)addObject:(id)object;
-(void)removeObjectAtIndex:(NSUInteger)index;
-(void)removeObject:(id)anObject;
-(void)insertObject:(id)anObject AtIndex:(NSUInteger)index;
-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
-(void)replaceObject:(id)anObject withObject:(id)newObject;


@end
