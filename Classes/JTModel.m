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

-(id)init
{
    return [self initWithDelegate:nil];
}

-(id)initWithDelegate:(id<JTModelDelegate>)delegate
{
    self=[super init];
    if (self)
    {
        _delegate=delegate;
    }
    
    return self;
}


#pragma mark - Properties -


-(NSString*)modelLastLoadKey
{
    //redefine this string to set unique key for each object
    return [NSString stringWithFormat:@"%@.lastLoadKey",NSStringFromClass(self.class)];
}



#pragma mark - Messages -



-(void)load
{
    //now implements nothing
    //declared only for subclassing
}




-(void)loadUpdates
{
    //now implements nothing
    //declared only for subclassing
}



-(void)loadMore
{
    //now implements nothing
    //declared only for subclassing
}



-(BOOL)willLoad
{
    if (self.isLoadingMore || self.isLoadingUpdates || self.isLoading)
        return NO;
    
    self.isLoading=YES;    
    if ([self.delegate respondsToSelector:@selector(modelWillLoad:)])
        [self.delegate modelWillLoad:self];
    
    return YES;
}



-(BOOL)willLoadUpdates
{
    if (self.isLoadingMore || self.isLoadingUpdates || self.isLoading)
        return NO;
    
    self.isLoadingUpdates=YES;
    if ([self.delegate respondsToSelector:@selector(modelWillUpdate:)])
        [self.delegate modelWillUpdate:self];
    
    return YES;
}



-(BOOL)willLoadMore
{
    if (self.isLoadingMore || self.isLoadingUpdates || self.isLoading)
        return NO;

    self.isLoadingMore=YES;
    if ([self.delegate respondsToSelector:@selector(modelWillLoadMore:)])
        [self.delegate modelWillLoadMore:self];
    
    return YES;
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

    //writing lastLoad time
    [NSUserDefaults.standardUserDefaults setObject:NSDate.date forKey:self.modelLastLoadKey];
    [NSUserDefaults.standardUserDefaults synchronize];

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



#pragma mark - Operations -


-(NSOperationQueue*)operationQueue
{
    if (!_operationQueue)
    //if not
        return NSOperationQueue.currentQueue;
    
    return _operationQueue;
}


-(NSMutableArray*)requestOperations
{
    if (!_requestOperations)
        _requestOperations=NSMutableArray.array;
    
    return _requestOperations;
}


-(void)addRequestOperation:(NSOperation*)requestOperation;
{
    if (!requestOperation)
        return;

    [self.requestOperations addObject:requestOperation];
    [self.operationQueue addOperation:requestOperation];
}


-(void)stopRequestOperations
{
    [self.requestOperations makeObjectsPerformSelector:@selector(setCompletionBlock:) withObject:nil];
    [self.requestOperations makeObjectsPerformSelector:@selector(cancel)];
    [self.requestOperations removeAllObjects];

    self.isLoading=NO;
    self.isLoadingMore=NO;
    self.isLoadingUpdates=NO;

    if ([self.delegate respondsToSelector:@selector(modelOperationsCanceled:)])
        [self.delegate modelOperationsCanceled:self];
}



@end
