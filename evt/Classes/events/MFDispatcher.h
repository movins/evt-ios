//
//  MFDispatcher.h
//  yylove
//
//  Created by lovis on 2018/5/25.
//

#import <Foundation/Foundation.h>

@protocol MFDispatcher <NSObject>
-(void)addListener:(NSString*)key selector:(SEL)selector;
-(void)addListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector;
-(void)addListener:(NSString*)key selector:(SEL)selector priority:(int)priority;
-(void)addListener:(NSString*)key selector:(SEL)selector priority:(int)priority async:(bool)async;
-(void)addListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector priority:(int)priority;
-(void)addListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector priority:(int)priority async:(bool)async;

-(void)removeListener:(NSString*)key selector:(SEL)selector;
-(void)removeListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector;
-(void)removeListener:(NSString*)key selector:(SEL)selector priority:(int)priority;
-(void)removeListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector priority:(int)priority;

-(void)dispatch:(NSString*)key evt:(MFBaseEvent*)evt;
-(void)doEvent:(NSString*)key data:(NSObject*)data;

-(void)clear;
-(void)clear:(NSString*)key listener:(NSObject*)listener;

-(void)setPause:(bool)paused;
@end
