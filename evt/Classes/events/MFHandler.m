//
//  MFHandler.m
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import "MFHandler.h"

@interface MFHandler ()
{
    
}
@property (weak, nonatomic) NSObject* listener;
@property (assign, nonatomic) SEL selector;
@property (assign, nonatomic) bool async;

@end

@implementation MFHandler
- (void)invoke:(MFBaseEvent *)evt {
    void (^doInvoke)(void) = ^{
        if ([_listener respondsToSelector:_selector]) {
            IMP imp = [_listener methodForSelector:_selector];
            void (*func)(id, SEL, MFBaseEvent*) = (void *)imp;
            func(_listener, _selector, evt);
        }
    };
    
    if ([NSThread isMainThread] || !_async) {
        doInvoke();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            doInvoke();
        });
    }
}

- (instancetype) init {
    self = [super init];
    if(self) {
        _selector = NULL;
        _listener = nil;
        _async = false;
    }
    return self;
}

- (instancetype)initWith:(NSObject *)listener selector:(SEL)selector async:(bool)async { 
    self = [self initWith:listener selector:selector];
    if(self) {
        _async = async;
    }
    return self;
}

- (instancetype)initWith:(NSObject *)listener selector:(SEL)selector { 
    self = [super init];
    if(self) {
        _selector = selector;
        _listener = listener;
    }
    return self;
}

- (bool)isNull { 
    return !_listener;
}

- (bool)has:(NSObject *)listener { 
    return (_listener == listener);
}

- (bool)same:(MFHandler *)handler { 
    return handler && (_listener == handler.listener) && (_selector == handler.selector);
}

@end
