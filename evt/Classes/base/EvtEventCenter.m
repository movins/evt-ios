//
//  EvtEventCenter.m
//
//  Created by lovis on 2018/5/21.
//

#import "EvtEventCenter.h"
#import "EvtEventConst.h"

@interface EvtEventBody: NSObject
@property (copy, nonatomic, readonly) NSString* key;
@property (assign, nonatomic, readonly) int priority;

+(void)clear;

-(instancetype)initWith:(EvtHandler*)handler priority:(int)priority;

-(EvtHandler*)handler;
-(bool)same:(EvtHandler*)handler priority:(int)priority;
-(bool)same:(NSObject*)listener;
-(void)exec:(EvtBaseEvent*)evt;
@end

@implementation EvtEventBody
static int _baseKey = 0;
static NSMutableDictionary* _handlers = nil;

+(void)clear {
    @synchronized(EvtEventBody.class) {
        [_handlers removeAllObjects];
    }
}

+(void)initialize {
    if (!_handlers) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _handlers = [[NSMutableDictionary alloc] initWithCapacity:1];
        });
    }
}

-(instancetype)initWith:(EvtHandler*)handler priority:(int)priority {
    self = [super init];
    if(self) {
        @synchronized (EvtEventBody.class) {
            _key = [NSString stringWithFormat:@"%d", ++_baseKey];
            [_handlers setValue:handler forKey:_key];
        }
        _priority = priority;
    }
    return self;
}

-(void)dealloc {
    @synchronized (EvtEventBody.class) {
        [_handlers removeObjectForKey:_key];
    }
}

-(MEvtHandler*)handler {
    return [_handlers valueForKey:_key];
}

-(bool)same:(EvtHandler*)handler priority:(int)priority{
    EvtHandler* data = [_handlers valueForKey:_key];
    return data && [data same:handler] && (_priority == priority);
}

-(bool)same:(NSObject*)listener {
    EvtHandler* data = [_handlers valueForKey:_key];
    return data && [data has:listener];
}

-(void)exec:(EvtBaseEvent*)evt{
    EvtHandler* data = [_handlers valueForKey:_key];
    if ([data isNull]) return;
    
    [data invoke:evt];
}
@end
//////////////////////////////////////
@interface EvtModuleBody: NSObject
@property (assign, nonatomic) bool paused;

-(instancetype)initWidth: (bool) enabled;
-(void)exec:(NSString*)key evt:(EvtBaseEvent*)evt;

-(void)add:(NSString*)key handler:(EvtHandler*)handler priority:(int)priority;
-(void)remove:(NSString*)key handler:(EvtHandler*)handler priority:(int)priority;
-(void)clear:(NSString*)key listener:(NSObject*)listener;
-(void)clear;
@end

@implementation EvtModuleBody
{
    NSMutableDictionary* _events;
}

-(instancetype)init{
    self = [super init];
    if(self) {
        _events = [NSMutableDictionary dictionary];
        _paused = false;
    }
    return self;
}

-(instancetype)initWidth: (bool) enabled {
    self = [self init];
    if(self) {
        _paused = enabled;
    }
    return self;
}

-(void)exec:(NSString*)key evt:(EvtBaseEvent*)evt {
    NSArray* list = [_events valueForKey:key];
    if (_paused || !list) return;
    
    @synchronized (self) {
        list = [list copy];
    }
    
    [self execItems:list evt:evt];
}

-(void)execItems:(NSArray*)list evt:(EvtBaseEvent*)evt{
    for (EvtEventBody* body in list) {
        [body exec:evt];
    }
}

-(int)indexOf:(NSArray*)list handler:(EvtHandler*)handler priority:(int)priority{
    int result = -1;
    for (int i = 0; i < list.count; ++i) {
        EvtEventBody* body = list[i];
        if(body && [body same:handler priority:priority]) {
            result = i;
            break;
        }
    }
    return result;
}

-(int)indexOf:(NSArray*)list listener:(NSObject*)listener {
    int result = -1;
    for (int i = 0; i < list.count; ++i) {
        EvtEventBody* body = list[i];
        if(body && [body same:listener]) {
            result = i;
            break;
        }
    }
    return result;
}

-(void)add:(NSString*)key handler:(EvtHandler*)handler priority:(int)priority {
    NSMutableArray* list = [_events valueForKey:key];
    if (!list) {
        list = [[NSMutableArray alloc]init];
        [_events setValue:list forKey:key];
    }
    @synchronized (self) {
        if ([self indexOf:list handler:handler priority:priority] < 0) {
            [list addObject:[[EvtEventBody alloc] initWith:handler priority:priority]];
            NSArray* descs = @[[NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:NO]];
            [list sortUsingDescriptors:descs];
        }
    }
}

-(void)remove:(NSString*)key handler:(EvtHandler*)handler priority:(int)priority {
    NSMutableArray* list = [_events valueForKey:key];
    if (!list) return;
    
    @synchronized (self) {
        int index;
        do {
            index = [self indexOf:list handler:handler priority:priority];
            if (index >= 0) [list removeObjectAtIndex:index];
        }while(index >= 0);
    }
}

-(void)clear:(NSString*)key listener:(NSObject*)listener {
    NSMutableArray* list = [_events valueForKey:key];
    if (!list) return;
    
    @synchronized (self) {
        int index;
        do {
            index = [self indexOf:list listener:listener];
            if (index >= 0) [list removeObjectAtIndex:index];
        }while(index >= 0);
    }
}

-(void)clear {
    @synchronized (self) {
        [_events removeAllObjects];
    }
}
@end
///////////////////////////////////////
@implementation EvtEventCenter

static NSMutableDictionary* _modules = nil;

+ (void)initialize {
    if (!_modules) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _modules = [[NSMutableDictionary alloc] initWithCapacity:1];
        });
    }
}

+ (void)clear { 
    @synchronized (EvtEventCenter.class) {
        [_modules removeAllObjects];
    }
}

+ (void)clear:(nullable NSString *)key subKey:(nullable NSString *)subKey listener:(nullable NSObject*)listener {
    EvtModuleBody* body = [_modules valueForKey:key];
    if (!body) return;
    
    [body clear:subKey listener:listener];
}

+ (void)clear:(nullable NSString *)key { 
    EvtModuleBody* body = [_modules valueForKey:key];
    if (!body) return;
    
    [body clear];
}

+ (void)setPause:(nullable NSString *)key enabled:(bool)enabled { 
    EvtModuleBody* body = [_modules valueForKey:key];
    if (!body) return;
    
    body.paused = enabled;
}

+ (void)dispatch:(nullable NSString *)key subKey:(nullable NSString *)subKey evt:(nullable EvtBaseEvent*)evt {
    if (EvtEventConst.switched) return;
    
    EvtModuleBody* body = [_modules valueForKey:key];
    if (!body) return;
    
    [body exec:subKey evt:evt];
}

+ (void)removeListener:(nullable NSString *)key subKey:(nullable NSString *)subKey handler:(nullable EvtHandler*)handler priority:(int)priority {
    EvtModuleBody* body = [_modules valueForKey:key];
    if (!body) return;
    
    [body remove:subKey handler:handler priority:priority];
}

+ (void)addListener:(nullable NSString *)key subKey:(nullable NSString *)subKey handler:(nullable EvtHandler *)handler priority:(int)priority { 
    if (!handler) return;
    EvtModuleBody* body = [_modules valueForKey:key];
    if (!body) {
        @synchronized (EvtEventCenter.class) {
            body = [[EvtModuleBody alloc]initWidth:EvtEventConst.switched];
            [_modules setObject:body forKey:key];
        }
    }
    [body add:subKey handler:handler priority:priority];
}

@end
