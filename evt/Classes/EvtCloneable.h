//
//  EvtCloneable.h
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>

@interface EvtCloneable: NSObject
-(id)clone;
-(void)clear;
-(bool)same:(EvtCloneable*)obj;
@end
