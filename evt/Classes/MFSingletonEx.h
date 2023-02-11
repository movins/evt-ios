//
//  MFDefines.h
//  yylove
//
//  Created by lovis on 2018/5/23.
//
#ifndef MF_SINGLETON_DEF
#define MF_SINGLETON_DEF(_type_)\
+ (_type_ *)sharedInstance;\
+ (instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+ (instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
- (instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
- (instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")))
#endif

#ifndef MF_SINGLETON_IMPL
#define MF_SINGLETON_IMPL(_type_)\
+ (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}
#endif
