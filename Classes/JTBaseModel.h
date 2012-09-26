//
//  JTBaseModel.h
//  Jeetrium
//
//  Created by Mihail Koltsov on 5/16/12.
//  Copyright (c) 2012 Intelvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JTModelDelegate;

@interface JTBaseModel : NSObject
{
    BOOL                        _isLoaded;
    BOOL                        _isLoading;
    BOOL                        _isLoadingMore;
    BOOL                        _noMoreObjects;
    BOOL                        _isOutdated;
    BOOL                        _hasChanged;
    
    __weak id<JTModelDelegate>  _delegate;
    NSMutableArray              *_delegates;
}

@property (nonatomic)               BOOL                        isLoaded;
@property (nonatomic)               BOOL                        isLoading;
@property (nonatomic)               BOOL                        isLoadingMore;
@property (nonatomic)               BOOL                        noMoreObjects;
@property (nonatomic)               BOOL                        isOutdated;
@property (nonatomic)               BOOL                        hasChanged;

@property (nonatomic, weak)         __weak id<JTModelDelegate>  delegate;
@property (nonatomic, readonly)     NSArray                     *delegates;





-(id)initWithDelegate:(id<JTModelDelegate>)delegate;
-(void)load;
-(void)loadUpdates;
-(void)loadMore;
-(void)refresh;
-(void)unload;

-(void)didLoad;
-(void)didLoadMore;
-(void)changed;
-(void)changedWithItems:(NSArray*)newItems;
-(void)error;
-(void)noMoreItems;

//-(void)addDelegate:(id<JTModelDelegate>)delegate;
//-(void)removeDelegate:(id<JTModelDelegate>)delegate;


@end


@protocol JTModelDelegate <NSObject>
@optional
    -(void)modelIsLoading:(JTBaseModel*)model; 
    -(void)modelIsLoadingMore:(JTBaseModel*)model;
    -(void)modelWillLoad:(JTBaseModel*)model;
    -(void)modelDidLoad:(JTBaseModel*)model; 
    -(void)modelDidLoadMore:(JTBaseModel*)model;
    -(void)modelNoMoreItems:(JTBaseModel*)model;
    -(void)modelChanged:(JTBaseModel*)model;
    -(void)modelChanged:(JTBaseModel*)model withItems:(NSArray*)newItems;
    -(void)modelError:(JTBaseModel*)model; 
@end
