//
//  MFBaseEvent.m
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import "MFBaseEvent.h"

@implementation MFBaseEvent

- (instancetype)initWith:(NSString *)key data:(id)data {
    self = [self initWith: key];
    if(self) {
        _eventData = data;
    }
    return self;
}

- (instancetype)initWith:(NSString *)key { 
    self = [super init];
    if(self) {
        _key = key;
    }
    return self;
}

@end
