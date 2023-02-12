//
//  EvtBaseEvent.h
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>

#ifndef EVT_EV_KEY
#define EVT_EV_KEY(__name) \
@property (class, copy, nonatomic, readonly) NSString* __name;
#endif

#ifndef EVT_EV_KEY_IMPL
#define EVT_EV_KEY_IMPL(__name, __value)\
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

