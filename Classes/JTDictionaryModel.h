//
//  JTDictionaryModel.h
//  
//
//  Created by mikk.22 on 29.08.12.
//  Copyright (c) 2012 mikk.22. All rights reserved.
//

#import "JTArrayModel.h"

@interface JTDictionaryModel : JTArrayModel
{
    NSDictionary    *_dataDictionary;
}

@property (nonatomic, readonly)     NSDictionary                     *dataDictionary;

-(NSArray*)objectsForKeyIndex:(NSInteger)sectionIndex;
-(id)objectAtIndex:(NSInteger)objectIndex forKeyIndex:(NSInteger)sectionIndex;
-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
