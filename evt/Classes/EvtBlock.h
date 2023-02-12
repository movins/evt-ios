//
//  EvtBlock.h
//
//  Created by lovis on 2018/5/22.
//

#import <Foundation/Foundation.h>

@protocol EvtModule;
@protocol EvtDispatcher;

@protocol EvtBlock <EvtDispatcher>
@property (assign, nonatomic, readonly) bool stoped;
@property (copy, nonatomic, readonly) id<EvtModule> module;

-(instancetype)initWidth:(id<EvtModule>)module;

-(void)destroy;
-(void)start;
-(void)stop;

-(void)log:(NSString*)tag format:(NSString*)format, ... NS_REQUIRES_NIL_TERMINATION;
@end
