//
//  JTModel.m
//  
//
//  Created by mikk.22 on 5/16/12.
//  Copyright (c) 2012 mikk.22. All rights reserved.
//

#import "JTArrayModel.h"

@interface JTArrayModel()

@property (nonatomic, strong)     NSArray     *dataObjects;

@end


@implementation JTArrayModel

@synthesize dataObjects=_dataObjects;


-(void)dealloc
{
    _dataObjects=nil;
}


#pragma mark -
#pragma mark - Properties

-(NSArray*)dataObjects
{
    if (!_dataObjects)
        _dataObjects=[NSArray array];
    
    return _dataObjects;
}






-(void)unload
{
    _dataObjects=nil;
    [super unload];
}


#pragma mark - Array Model messages -


-(void)addObject:(id)object
{
    _dataObjects=[self.dataObjects arrayByAddingObject:object];
    //[self changedAtIndexes:[NSIndexSet indexSetWithIndex:(_dataObjects.count-1)]];
    [self didChange];
}

-(void)removeObjectAtIndex:(NSUInteger)index
{
    if (index<self.dataObjects.count)
    {
        NSMutableArray *mutableDataObjects=[NSMutableArray arrayWithArray:self.dataObjects];
        [mutableDataObjects removeObjectAtIndex:index];
        _dataObjects=[NSArray arrayWithArray:mutableDataObjects];
        [self didChange];
    }
}


-(void)removeObject:(id)anObject
{
    if (anObject)
    {
        NSMutableArray *mutableDataObjects=[NSMutableArray arrayWithArray:self.dataObjects];
        [mutableDataObjects removeObject:anObject];
        _dataObjects=[NSArray arrayWithArray:mutableDataObjects];
        [self didChange];
    }
}

-(void)insertObject:(id)anObject AtIndex:(NSUInteger)index
{
    if (index<self.dataObjects.count && anObject)
    {
        NSMutableArray *mutableDataObjects=[NSMutableArray arrayWithArray:self.dataObjects];
        [mutableDataObjects insertObject:anObject atIndex:index];
        _dataObjects=[NSArray arrayWithArray:mutableDataObjects];
        [self didChange];
    }
}


-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject 
{
    if (index<self.dataObjects.count && anObject)
    {
        NSMutableArray *mutableDataObjects=[NSMutableArray arrayWithArray:self.dataObjects];
        [mutableDataObjects replaceObjectAtIndex:index withObject:anObject];
        _dataObjects=[NSArray arrayWithArray:mutableDataObjects];
        [self didChange];
    }
}


-(void)replaceObject:(id)anObject withObject:(id)newObject
{
    if (newObject && anObject)
    {
        NSUInteger oldObjIndex=[self.dataObjects indexOfObject:anObject];
        
        if (oldObjIndex!=NSNotFound)
        {
            NSMutableArray *mutableDataObjects=[NSMutableArray arrayWithArray:self.dataObjects];
            [mutableDataObjects replaceObjectAtIndex:oldObjIndex withObject:newObject];
            _dataObjects=[NSArray arrayWithArray:mutableDataObjects];
            [self didChange];
        } else
        {
            //DLog(@"OBJECT %@ NOT FOUND",anObject);
        }
    }
}


@end
