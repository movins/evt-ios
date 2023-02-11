//
//  MFBlock.h
//  yylove
//
//  Created by lovis on 2018/5/22.
//

#import <Foundation/Foundation.h>

@protocol MFModule;
@protocol MFDispatcher;

@protocol MFBlock <MFDispatcher>
@property (assign, nonatomic, readonly) bool stoped;
@property (copy, nonatomic, readonly) id<MFModule> module;

-(instancetype)initWidth:(id<MFModule>)module;

-(void)destroy;
-(void)start;
-(void)stop;

-(void)log:(NSString*)tag format:(NSString*)format, ... NS_REQUIRES_NIL_TERMINATION;
@end
