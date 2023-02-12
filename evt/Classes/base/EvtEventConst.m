//
//  EvtEventConst.m
//
//  Created by lovis on 2018/5/21.
//

#import "EvtEventConst.h"
#import "EvtEventCenter.h"
// #import "EvtLogger.h"

@implementation EvtEventConst

static bool _switched = false;

+ (void)clear { 
    [EvtEventCenter clear];
}

+ (void)log:(NSString *)tag, ... {
    
}

+ (bool)isSwitched {
    return _switched;
}

+ (void)setSwitched:(bool)enabled {
    _switched = enabled;
}

+ (void)log:(NSString *)tag format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString* content = [[NSString alloc]initWithFormat:format arguments:args];
    va_end(args);
    // EvtLogInfo(tag, @"%@", content);
}

@end
