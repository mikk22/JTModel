//
//  JTBaseModel.h
//
//
//  Created by mikk.22 on 5/16/12.
//  Copyright (c) 2012 mikk.22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTModelDelegate.h"

@interface JTModel : NSObject
{
    BOOL                        _isLoaded;
    BOOL                        _isLoading;
    BOOL                        _isLoadingUpdates;
    BOOL                        _isLoadingMore;
    BOOL                        _noMoreObjects;
    BOOL                        _isOutdated;
    BOOL                        _hasChanged;
    
    __weak id<JTModelDelegate>  _delegate;
}

@property (nonatomic, assign)       BOOL                        isLoaded;
@property (nonatomic, assign)       BOOL                        isLoading;
@property (nonatomic, assign)       BOOL                        isLoadingUpdates;
@property (nonatomic, assign)       BOOL                        isLoadingMore;
@property (nonatomic, assign)       BOOL                        noMoreObjects;
@property (nonatomic, assign)       BOOL                        isOutdated;
@property (nonatomic, assign)       BOOL                        hasChanged;

@property (nonatomic, weak)         __weak id<JTModelDelegate>  delegate;

//key used
@property (nonatomic, readonly)     NSString                    *modelLastLoadKey;

//operations
@property (nonatomic, strong)   NSMutableArray                  *requestOperations;
@property (nonatomic, strong)   NSOperationQueue                *operationQueue;


-(id)initWithDelegate:(id<JTModelDelegate>)delegate;
-(void)unload;

-(void)load;
-(void)loadUpdates;
-(void)loadMore;

-(void)didLoad;
-(void)didLoadMoreWithObjects:(id)newItems;
-(void)didChange;
-(void)didUpdateWithObjects:(id)newObjects;
-(void)didUpdateWithItems:(id)newItems __attribute__((deprecated));

//user these actions in subclasses with default actions provided in delegate
-(void)willPerformAction:(NSString*)action withObjects:(id)objects;;
-(void)didPerformAction:(NSString*)action withObjects:(id)objects;

//-(void)error __attribute__((deprecated));
-(void)error:(NSError*)aError;
-(void)progress:(CGFloat)progressValue forItem:(NSObject*)item;

//operations

-(void)addRequestOperation:(NSOperation*)requestOperation;
-(void)stopRequestOperations;


@end
