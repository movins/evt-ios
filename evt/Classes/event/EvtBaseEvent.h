//
//  MFBaseEvent.h
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>

#ifndef MFEV_KEY
#define MFEV_KEY(__name) \
@property (class, copy, nonatomic, readonly) NSString* __name;
#endif

#ifndef MFEV_KEY_IMPL
#define MFEV_KEY_IMPL(__name, __value)\
static NSString* _##__name = __value;\
+(NSString*) __name {\
    return _##__name;\
}
#endif

@interface MFBaseEvent : NSObject
@property (copy, readonly) NSString* key;
@property (strong, readwrite) id eventData;

-(instancetype)initWith:(NSString*)key;
-(instancetype)initWith:(NSString*)key data:(id)data;
@end

