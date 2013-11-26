//
//  JTDictionaryModel.m
//  
//
//  Created by mikk.22 on 29.08.12.
//  Copyright (c) 2012 mikk.22. All rights reserved.
//

#import "JTDictionaryModel.h"

@implementation JTDictionaryModel

@synthesize dataDictionary=_dataDictionary;

-(NSArray*)objectsForKeyIndex:(NSInteger)sectionIndex
{
    NSArray *sections=[self.dataDictionary allKeys];
    if (sectionIndex<sections.count)
    {
        NSString *keyForSection=[sections objectAtIndex:sectionIndex];
        NSArray *objectsForSection=[self.dataDictionary objectForKey:keyForSection];
        return objectsForSection;
    }
    
    return [NSArray array];
}


-(id)objectAtIndex:(NSInteger)objectIndex forKeyIndex:(NSInteger)sectionIndex
{
    NSArray *sections=[self.dataDictionary allKeys];
    if (sectionIndex<sections.count)
    {
        NSString *keyForSection=[sections objectAtIndex:sectionIndex];
        NSArray *objectsForSection=[self.dataDictionary objectForKey:keyForSection];
        
        if (objectIndex < objectsForSection.count)
            return [objectsForSection objectAtIndex:objectIndex];
    }
    
    return nil;
}

-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject && aKey)
    {
        NSMutableDictionary *mutableDataObjects=[NSMutableDictionary dictionaryWithDictionary:_dataDictionary];
        [mutableDataObjects setObject:anObject forKey:aKey];
        _dataDictionary=[NSDictionary dictionaryWithDictionary:mutableDataObjects];
    }
}



@end
