//
//  MFModule.h
//  yylove
//
//  Created by lovis on 2018/5/22.
//

#import <Foundation/Foundation.h>

@protocol MFBlock;
@protocol MFDispatcher;

@protocol MFModule <MFDispatcher>
@property (copy, nonatomic, readonly, getter=api) id<NSObject> api;

-(instancetype)initWidth:(id<NSObject>)api;

-(void)destroy;
-(void)start;
-(void)stop;

-(void)log:(NSString*)tag content:(NSString*)content;

-(void)addBlock:(NSString*)key block:(id<MFBlock>)block;
-(void)removeBlock:(NSString*)key;
-(id<MFBlock>)block:(NSString*)key;

-(void)addBlockListener:(NSString*)blockKey evtKey:(NSString*)evtKey listener:(NSObject*)listener selector:(SEL)selector;
-(void)removeBlockListener:(NSString*)blockKey evtKey:(NSString*)evtKey listener:(NSObject*)listener selector:(SEL)selector;
@end
