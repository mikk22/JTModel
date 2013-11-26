//
//  JTBaseModel.m
//  
//
//  Created by mikk.22 on 5/16/12.
//  Copyright (c) 2012 mikk.22. All rights reserved.
//

#import "JTModel.h"

@interface JTModel()

@end

@implementation JTModel

-(id)initWithDelegate:(id<JTModelDelegate>)delegate
{
    self=[self init];
    if (self)
    {
        self.delegate=delegate;
    }
    
    return self;
}


#pragma mark - Messages -



-(void)load
{
    if (self.isLoadingMore || self.isLoadingUpdates || self.isLoading)
        return;
    
    self.isLoading=YES;    
    if ([self.delegate respondsToSelector:@selector(modelWillLoad:)])
        [self.delegate modelWillLoad:self];
}




-(void)loadUpdates
{
    if (self.isLoadingMore || self.isLoadingUpdates || self.isLoading)
        return;
    
    self.isLoadingUpdates=YES;
    if ([self.delegate respondsToSelector:@selector(modelWillUpdate:)])
        [self.delegate modelWillUpdate:self];
}



-(void)loadMore
{
    if (self.isLoadingMore || self.isLoadingUpdates || self.isLoading)
        return;

    self.isLoadingMore=YES;
    if ([self.delegate respondsToSelector:@selector(modelWillLoadMore:)])
        [self.delegate modelWillLoadMore:self];
}



-(void)unload
{
    self.isLoaded=NO;
}




#pragma mark -

-(void)willPerformAction:(NSString*)action withObjects:(id)objects
{
    //used for compability
    if ([action isEqual:JTModelLoadAction])
    {
        [self load];
    } else
    if ([action isEqual:JTModelUpdateAction])
    {
        [self loadMore];
    } else
    if ([action isEqual:JTModelLoadMoreAction])
    {
        [self loadUpdates];
    }

    if ([self.delegate respondsToSelector:@selector(model:willPerformAction:withObjects:)])
        [self.delegate model:self willPerformAction:action withObjects:objects];
}

-(void)didPerformAction:(NSString*)action withObjects:(id)objects
{
    //used for compability
    if ([action isEqual:JTModelLoadAction])
    {
        [self didLoad];
    } else
    if ([action isEqual:JTModelUpdateAction])
    {
        [self didUpdateWithObjects:objects];
    } else
    if ([action isEqual:JTModelLoadMoreAction])
    {
        [self didLoadMoreWithObjects:objects];
    }

    if ([self.delegate respondsToSelector:@selector(model:didPerformAction:withObjects:)])
        [self.delegate model:self didPerformAction:action withObjects:objects];
}



-(void)didLoad
{
    self.isLoading=NO;
    self.isLoaded=YES;
    self.hasChanged=NO;

//    [self changed];

    if ([self.delegate respondsToSelector:@selector(modelDidLoad:)])
        [self.delegate modelDidLoad:self];
}






-(void)didLoadMoreWithObjects:(NSArray*)newItems
{
    self.isLoadingMore=NO;
    self.isLoaded=YES;

    if (!newItems.count)
        self.noMoreObjects=YES;
    
//    [self changed];
    
    if ([self.delegate respondsToSelector:@selector(model:didLoadMoreWithObjects:)])
        [self.delegate model:self didLoadMoreWithObjects:newItems];
}


-(void)didChange
{
    if ([self.delegate respondsToSelector:@selector(modelChanged:)])
        [self.delegate modelChanged:self];
    
    self.hasChanged=YES;
}



-(void)error:(NSError*)aError
{
    self.isLoading=NO;
    self.isLoadingMore=NO;
    self.isLoadingUpdates=NO;
    if ([self.delegate respondsToSelector:@selector(model:error:)])
        [self.delegate model:self error:aError];
}




-(void)progress:(CGFloat)progressValue forItem:(NSObject*)item
{
    if ([self.delegate respondsToSelector:@selector(model:progress:forObject:)])
        [self.delegate model:self progress:progressValue forObject:item];
}





-(void)didUpdateWithObjects:(id)newObjects
{
    self.hasChanged=YES;

    if ([self.delegate respondsToSelector:@selector(model:didUpdateWithObjects:)])
        [self.delegate model:self didUpdateWithObjects:newObjects];
    
    [self didChange];
}

-(void)didUpdateWithItems:(id)newItems __attribute__((deprecated))
{
    [self didUpdateWithObjects:newItems];
}



@end
