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
-(void)unload;

-(void)didLoad;
-(void)didLoadMoreWithItems:(NSArray*)newItems;;
-(void)noMoreItems;
-(void)changed;
-(void)updatedWithItems:(NSArray*)newItems;
//-(void)error __attribute__((deprecated));
-(void)error:(NSError*)aError;

//-(void)addDelegate:(id<JTModelDelegate>)delegate;
//-(void)removeDelegate:(id<JTModelDelegate>)delegate;


@end


@protocol JTModelDelegate <NSObject>
@optional
    -(void)modelIsLoading:(JTBaseModel*)model; 
    -(void)modelIsLoadingMore:(JTBaseModel*)model;
    -(void)modelWillLoad:(JTBaseModel*)model;
    -(void)modelDidLoad:(JTBaseModel*)model; 
    -(void)model:(JTBaseModel*)model didLoadMoreWithItems:(NSArray*)newItems;
    -(void)modelNoMoreItems:(JTBaseModel*)model;
    -(void)modelChanged:(JTBaseModel*)model;
    -(void)modelUpdated:(JTBaseModel*)model withItems:(NSArray*)newItems;
//    -(void)modelError:(JTBaseModel*)model __attribute__((deprecated));
    -(void)model:(JTBaseModel*)model error:(NSError*)aError;
@end
