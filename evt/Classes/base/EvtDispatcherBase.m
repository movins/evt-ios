//
//  EvtDispatcher.m
//
//  Created by lovis on 2018/5/21.
//

#import "EvtDispatcherBase.h"
#import "EvtEventCenter.h"
#import "EvtHandler.h"
#import "EvtEventConst.h"

@implementation EvtDispatcherBase
{
    NSString* _baseKey;
}

-(instancetype)init {
    self = [super init];
    if(self) {
        _baseKey = [self description];
    }
    return self;
}

- (void)setPause:(bool)paused { 
    [EvtEventCenter setPause:_baseKey enabled:paused];
}

- (void)clear:(NSString *)key listener:(NSObject *)listener { 
    [EvtEventCenter clear:_baseKey subKey:key listener:listener];
}

- (void)clear { 
    [EvtEventCenter clear:_baseKey];
}

- (void)doEvent:(NSString *)key data:(NSObject *)data { 
    EvtBaseEvent* evt = [[EvtBaseEvent alloc] initWith:key data:data];
    [self dispatch:key evt:evt];
}

- (void)dispatch:(NSString *)key evt:(EvtBaseEvent *)evt { 
    [EvtEventCenter dispatch:_baseKey subKey:key evt:evt];
}

- (void)removeListener:(NSString *)key listener:(NSObject *)listener selector:(SEL)selector priority:(int)priority { 
    [EvtEventCenter removeListener:_baseKey subKey:key handler:[[EvtHandler alloc]initWith:listener selector:selector] priority:priority];
}

- (void)removeListener:(NSString *)key selector:(SEL)selector priority:(int)priority {
    [self removeListener:key listener:self selector:selector priority:priority];
}

-(void)removeListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector {
    [self removeListener:key listener:listener selector:selector priority:EvtNormal];
}

- (void)removeListener:(NSString *)key selector:(SEL)selector {
    [self removeListener:key listener:self selector:selector priority:EvtNormal];
}

- (void)addListener:(NSString *)key listener:(NSObject *)listener selector:(SEL)selector priority:(int)priority async:(bool)async { 
    [EvtEventCenter addListener:_baseKey subKey:key handler:[[EvtHandler alloc]initWith:listener selector:selector async:async] priority:priority];
}

- (void)addListener:(NSString *)key listener:(NSObject *)listener selector:(SEL)selector priority:(int)priority { 
    [self addListener:key listener:listener selector:selector priority:priority async:false];
}

- (void)addListener:(NSString *)key selector:(SEL)selector priority:(int)priority async:(bool)async { 
    [self addListener:key listener:self selector:selector priority:priority async:async];
}

- (void)addListener:(NSString *)key selector:(SEL)selector priority:(int)priority { 
    [self addListener:key listener:self selector:selector priority:priority async:false];
}

-(void)addListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector {
    [self addListener:key listener:listener selector:selector priority:EvtNormal async:false];
}

- (void)addListener:(NSString *)key selector:(SEL)selector { 
   [self addListener:key listener:self selector:selector priority:EvtNormal async:false];
}

@end
