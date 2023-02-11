//
//  MFHandler.h
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>
#import "MFBaseEvent.h"

@interface MFHandler : NSObject
-(instancetype)initWith:(NSObject*)listener selector:(SEL)selector;
-(instancetype)initWith:(NSObject*)listener selector:(SEL)selector async:(bool)async;

-(void)invoke:(MFBaseEvent*)evt;

-(bool)same:(MFHandler*)handler;
-(bool)has:(NSObject*)listener;

-(bool)isNull;
@end
