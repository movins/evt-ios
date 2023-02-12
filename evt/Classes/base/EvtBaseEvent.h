//
//  EvtBaseEvent.h
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>

#ifndef MVTEV_KEY
#define MVTEV_KEY(__name) \
@property (class, copy, nonatomic, readonly) NSString* __name;
#endif

#ifndef MVTEV_KEY_IMPL
#define MVTEV_KEY_IMPL(__name, __value)\
static NSString* _##__name = __value;\
+(NSString*) __name {\
    return _##__name;\
}
#endif

@interface EvtBaseEvent : NSObject
@property (copy, readonly) NSString* key;
@property (strong, readwrite) id eventData;

-(instancetype)initWith:(NSString*)key;
-(instancetype)initWith:(NSString*)key data:(id)data;
@end

