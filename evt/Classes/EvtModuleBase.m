//
//  EvtModuleBase.m
//
//  Created by lovis on 2018/5/22.
//

#import "EvtModuleBase.h"
#import "EvtBlock.h"

@implementation EvtModuleBase
{
    NSMutableDictionary* _blocks;
    id<NSObject> _api;
}

@synthesize api = _api;

- (instancetype)init {
    self = [super init];
    if (self) {
        _blocks = [NSMutableDictionary dictionary];
        _api = nil;
    }
    return self;
}

-(instancetype)initWidth:(id<NSObject>)api {
    self = [self init];
    if (self) {
        _api = api;
    }
    return self;
}

-(void)destroy {
    for (id<EvtBlock> block in _blocks) {
        [block stop];
        [block destroy];
    }
    [_blocks removeAllObjects];
    _api = nil;
    _blocks = nil;
}

-(void)start {
    for (id<EvtBlock> block in _blocks) {
        [block start];
    }
    [self setPause:false];
}

-(void)stop {
    [self setPause:true];
    for (id<EvtBlock> block in _blocks) {
        [block stop];
    }
}

-(void)log:(NSString*)tag content:(NSString*)content {
    // EvtLogInfo(tag, @"%@", content);
}

-(void)addBlock:(NSString*)key block:(id<EvtBlock>)block {
    if (!block) return;
    [_blocks setObject:block forKey:key];
    
    [block start];
}

-(void)removeBlock:(NSString*)key {
    id<EvtBlock> block = [_blocks valueForKey:key];
    if (block) {
        [block stop];
        [block destroy];
        [_blocks removeObjectForKey:key];
    }
}

-(id<EvtBlock>)block:(NSString*)key {
    return [_blocks valueForKey:key];
}

-(void)addBlockListener:(NSString*)blockKey evtKey:(NSString*)evtKey listener:(NSObject*)listener selector:(SEL)selector {
    id<EvtBlock> block = [_blocks valueForKey:blockKey];
    if (block) {
        [block addListener:evtKey listener:listener selector:selector];
    }
}
-(void)removeBlockListener:(NSString*)blockKey evtKey:(NSString*)evtKey listener:(NSObject*)listener selector:(SEL)selector {
    id<EvtBlock> block = [_blocks valueForKey:blockKey];
    if (block) {
        [block removeListener:evtKey listener:listener selector:selector];
    }
}
@end
