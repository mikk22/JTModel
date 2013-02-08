//
//  JTBaseModel.m
//  Jeetrium
//
//  Created by Mihail Koltsov on 5/16/12.
//  Copyright (c) 2012 Intelvision. All rights reserved.
//

#import "JTBaseModel.h"

@interface JTBaseModel()


@end

@implementation JTBaseModel

@synthesize isLoaded=_isLoaded;
@synthesize isLoading=_isLoading;
@synthesize isLoadingMore=_isLoadingMore;
@synthesize noMoreObjects=_noMoreObjects;
@synthesize isOutdated=_isOutdated;
@synthesize hasChanged=_hasChanged;

@synthesize delegate=_delegate;

-(id)initWithDelegate:(id<JTModelDelegate>)delegate
{
    self=[self init];
    if (self)
    {
        self.delegate=delegate;
    }
    
    return self;
}

/*
-(void)addDelegate:(id<JTModelDelegate>)delegate
{
    if (!_delegates)
        _delegates=[NSMutableArray array];
    
    DLog(@"DELEGATE %@",delegate);
    
    NSValue *newValue=[NSValue valueWithNonretainedObject:delegate];
    
    DLog(@"VALUE %@",newValue);
    
    [_delegates addObject:newValue];

    
    
    DLog(@"DELEGATES %@",_delegates);
    
    [self checkValues];
    
}

-(void)checkValues
{
    for (NSValue *value in _delegates)
    {
        //value = [array objectAtIndex:x];
        id myObj = [value nonretainedObjectValue];

         
        
        DLog(@"OBJ %@",myObj);
    }
}


-(void)removeDelegate:(id<JTModelDelegate>)delegate
{
    if (!_delegates || !_delegates.count)
        return;

    DLog(@"COUNT BEFORE %d",_delegates.count);

    NSUInteger index=[_delegates indexOfObject:delegate];
    
    DLog(@"INDEX %d",index);
    
    if (index==NSNotFound)
    {
        DLog(@"NOT FOUND");
    } else
    {
        [_delegates removeObject:delegate];
    }
    
    DLog(@"COUNT AFTER %d",_delegates.count);
}
*/

#pragma mark - Properties -


-(NSArray*)delegates
{
    if (!_delegates)
        _delegates=[NSMutableArray array];
    
    return [NSArray arrayWithArray:_delegates];
}



#pragma mark - Messages -



-(void)load
{
    self.isLoading=YES;    
    if ([self.delegate respondsToSelector:@selector(modelWillLoad:)])
        [self.delegate modelWillLoad:self];
    
    if ([self.delegate respondsToSelector:@selector(modelIsLoading:)])
        [self.delegate modelIsLoading:self];
}




-(void)loadUpdates
{
    //the same as load
    [self load];
}



-(void)loadMore
{
    self.isLoadingMore=YES;
    if ([self.delegate respondsToSelector:@selector(modelIsLoadingMore:)])
        [self.delegate modelIsLoadingMore:self];
}



-(void)unload
{
    self.isLoaded=NO;
}




-(void)didLoad
{
    self.isLoading=NO;
    self.isLoaded=YES;
    self.noMoreObjects=NO;
    self.hasChanged=NO;

//    [self changed];

    if ([self.delegate respondsToSelector:@selector(modelDidLoad:)])
        [self.delegate modelDidLoad:self];
}






-(void)didLoadMoreWithItems:(NSArray*)newItems
{
    self.isLoadingMore=NO;
    self.isLoaded=YES;

    if (!newItems.count)
        self.noMoreObjects=YES;
    
//    [self changed];
    
    if ([self.delegate respondsToSelector:@selector(model:didLoadMoreWithItems:)])
        [self.delegate model:self didLoadMoreWithItems:newItems];
}


-(void)changed
{
    if ([self.delegate respondsToSelector:@selector(modelChanged:)])
        [self.delegate modelChanged:self];
    
    self.hasChanged=YES;
}


/*
-(void)error
{
    if ([self.delegate respondsToSelector:@selector(modelError:)])
        [self.delegate modelError:self];
}
*/


-(void)error:(NSError*)aError
{
    if ([self.delegate respondsToSelector:@selector(model:error:)])
        [self.delegate model:self error:aError];
}




-(void)progress:(CGFloat)progressValue forItem:(NSObject*)item
{
    if ([self.delegate respondsToSelector:@selector(model:progress:forItem:)])
        [self.delegate model:self progress:progressValue forItem:item];
}






-(void)noMoreItems
{
    self.noMoreObjects=YES;
    
    if ([self.delegate respondsToSelector:@selector(modelNoMoreItems:)])
        [self.delegate modelNoMoreItems:self];
}




-(void)updatedWithItems:(NSArray*)newItems
{
    self.hasChanged=YES;

    if ([self.delegate respondsToSelector:@selector(modelUpdated:withItems:)])
        [self.delegate modelUpdated:self withItems:newItems];
    if ([self.delegate respondsToSelector:@selector(modelChanged:)])
        [self.delegate modelChanged:self];
}


@end
