//
//  JTDictionaryModel.h
//  Devisa
//
//  Created by user on 29.08.12.
//  Copyright (c) 2012 Intelvision. All rights reserved.
//

#import "JTArrayModel.h"

@interface JTDictionaryModel : JTArrayModel
{
    NSDictionary    *_dataDictionary;
}

@property (nonatomic, readonly)     NSDictionary                     *dataDictionary;

-(NSArray*)objectsForKeyIndex:(NSInteger)sectionIndex;
-(id)objectAtIndex:(NSInteger)objectIndex forKeyIndex:(NSInteger)sectionIndex;


@end
