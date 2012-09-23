//
//  JTDictionaryModel.m
//  Devisa
//
//  Created by user on 29.08.12.
//  Copyright (c) 2012 Intelvision. All rights reserved.
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


@end
