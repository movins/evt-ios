//
//  EvtHandler.h
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>
#import "EvtBaseEvent.h"

@interface EvtHandler : NSObject
-(instancetype)initWith:(NSObject*)listener selector:(SEL)selector;
-(instancetype)initWith:(NSObject*)listener selector:(SEL)selector async:(bool)async;

-(void)invoke:(EvtBaseEvent*)evt;

-(bool)same:(EvtHandler*)handler;
-(bool)has:(NSObject*)listener;

-(bool)isNull;
@end
