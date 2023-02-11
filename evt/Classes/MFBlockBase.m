//
//  MFBlockBase.m
//  yylove
//
//  Created by lovis on 2018/5/22.
//

#import "MFBlockBase.h"
#import "MFModule.h"

@implementation MFBlockBase
{
    NSMutableDictionary* _handlers;
    id<MFModule> _module;
    bool _stoped;
}

@synthesize module = _module;
@synthesize stoped = _stoped;

- (instancetype)init {
    self = [super init];
    if (self) {
        _handlers = [NSMutableDictionary dictionary];
        _stoped = false;
    }
    return self;
}

-(instancetype)initWidth:(id<MFModule>)module {
    self = [self init];
    if (self) {
        _module = module;
    }
    return self;
}

- (NSObject *)invoke:(NSString *)cmd args:(NSArray *)args { 
    NSObject* result = nil;
    NSString* name = [_handlers valueForKey:cmd];
    if (name) {
        SEL selecter = NSSelectorFromString(name);
        if ([self respondsToSelector:selecter]) {
            IMP imp = [self methodForSelector:selecter];
            NSObject* (*func)(id, SEL, NSArray*) = (void *)imp;
            result = func(self, selecter, args);
        }
    }
    
    return result;
}

- (void)log:(NSString *)tag format:(NSString *)format, ... { 
    if (!_module) return;
    
    va_list args;
    va_start(args, format);
    NSString* content = [[NSString alloc]initWithFormat:format arguments:args];
    va_end(args);
    
    [_module log:tag content:content];
}

-(void)destroy {
    [self clear];
    [_handlers removeAllObjects];
}

-(void)start {
    _stoped = false;
    [self setPause:false];
}

-(void)stop {
    _stoped = true;
    [self setPause:true];
}

@end
