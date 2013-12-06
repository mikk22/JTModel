//
//  JTModelDelegate.h
//  
//
//  Created by mikk.22 on 26.11.13.
//  Copyright (c) 2013 mikk.22. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JTModel;

static NSString* const JTModelLoadAction=       @"JTModel.load";
static NSString* const JTModelLoadMoreAction=   @"JTModel.loadMore";
static NSString* const JTModelUpdateAction=     @"JTModel.update";

@protocol JTModelDelegate <NSObject>
@optional
//you can add your own actions and react on them in subclass
-(void)model:(JTModel*)model willPerformAction:(NSString*)action withObjects:(id)objects;
-(void)model:(JTModel*)model didPerformAction:(NSString*)action withObjects:(id)objects;

-(void)modelWillLoad:(JTModel*)model;
-(void)modelDidLoad:(JTModel*)model;

-(void)modelWillLoadMore:(JTModel*)model;
-(void)model:(JTModel*)model didLoadMoreWithObjects:(id)newObjects;

-(void)modelWillUpdate:(JTModel*)model;
-(void)model:(JTModel*)model didUpdateWithObjects:(id)newObjects;

-(void)modelChanged:(JTModel*)model;

-(void)model:(JTModel*)model error:(NSError*)aError;
-(void)model:(JTModel*)model progress:(CGFloat)progressValue forObject:(id)object;
//    -(void)modelError:(JTBaseModel*)model __attribute__((deprecated));

-(void)modelOperationsCanceled:(JTModel*)model;
@end
