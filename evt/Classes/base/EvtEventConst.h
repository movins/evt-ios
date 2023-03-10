//
//  EvtEventConst.h
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EvtPriority) {
    EvtLow,
    EvtNormal,
    EvtHigh,
};

@interface EvtEventConst : NSObject
@property (class, assign, nonatomic, getter=isSwitched) bool switched;

+(void)clear;
+(void)log:(NSString*)tag format:(NSString*)format, ... NS_REQUIRES_NIL_TERMINATION;

@end
