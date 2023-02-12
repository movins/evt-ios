//
//  EvtEventCenter.h
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>
#import "EvtBaseEvent.h"
#import "EvtHandler.h"

@interface EvtEventCenter : NSObject

+(void)addListener:(nullable NSString*)key subKey:(nullable NSString*)subKey handler:(nullable  EvtHandler*)handler priority:(int)priority;
+(void)removeListener:(nullable NSString*)key subKey:(nullable NSString*)subKey handler:(nullable EvtHandler*)handler priority:(int)priority;
+(void)dispatch:(nullable NSString*)key subKey:(nullable NSString*)subKey evt:(nullable EvtBaseEvent*)evt;
+(void)setPause:(nullable NSString*)key enabled:(bool)enabled;

+(void)clear:(nullable NSString*)key;
+(void)clear:(nullable NSString*)key subKey:(nullable NSString*)subKey listener:(nullable NSObject*)listener;

+(void)clear;

@end
