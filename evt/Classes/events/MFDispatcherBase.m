//
//  MFDispatcher.m
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import "MFDispatcherBase.h"
#import "MFEventCenter.h"
#import "MFHandler.h"
#import "MFEventConst.h"

@implementation MFDispatcherBase
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
    [MFEventCenter setPause:_baseKey enabled:paused];
}

- (void)clear:(NSString *)key listener:(NSObject *)listener { 
    [MFEventCenter clear:_baseKey subKey:key listener:listener];
}

- (void)clear { 
    [MFEventCenter clear:_baseKey];
}

- (void)doEvent:(NSString *)key data:(NSObject *)data { 
    MFBaseEvent* evt = [[MFBaseEvent alloc] initWith:key data:data];
    [self dispatch:key evt:evt];
}

- (void)dispatch:(NSString *)key evt:(MFBaseEvent *)evt { 
    [MFEventCenter dispatch:_baseKey subKey:key evt:evt];
}

- (void)removeListener:(NSString *)key listener:(NSObject *)listener selector:(SEL)selector priority:(int)priority { 
    [MFEventCenter removeListener:_baseKey subKey:key handler:[[MFHandler alloc]initWith:listener selector:selector] priority:priority];
}

- (void)removeListener:(NSString *)key selector:(SEL)selector priority:(int)priority {
    [self removeListener:key listener:self selector:selector priority:priority];
}

-(void)removeListener:(NSString*)key listener:(NSObject*)listener selector:(SEL)selector {
    [self removeListener:key listener:listener selector:selector priority:MFNormal];
}

- (void)removeListener:(NSString *)key selector:(SEL)selector {
    [self removeListener:key listener:self selector:selector priority:MFNormal];
}

- (void)addListener:(NSString *)key listener:(NSObject *)listener selector:(SEL)selector priority:(int)priority async:(bool)async { 
    [MFEventCenter addListener:_baseKey subKey:key handler:[[MFHandler alloc]initWith:listener selector:selector async:async] priority:priority];
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
    [self addListener:key listener:listener selector:selector priority:MFNormal async:false];
}

- (void)addListener:(NSString *)key selector:(SEL)selector { 
   [self addListener:key listener:self selector:selector priority:MFNormal async:false];
}

@end
