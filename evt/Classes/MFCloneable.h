//
//  MFCloneable.h
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import <Foundation/Foundation.h>

@interface MFCloneable: NSObject
-(id)clone;
-(void)clear;
-(bool)same:(MFCloneable*)obj;
@end
