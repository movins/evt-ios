//
//  MFEventConst.m
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import "MFEventConst.h"
#import "MFEventCenter.h"
#import "MFLogger.h"

@implementation MFEventConst

static bool _switched = false;

+ (void)clear { 
    [MFEventCenter clear];
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
    MFLogInfo(tag, @"%@", content);
}

@end
