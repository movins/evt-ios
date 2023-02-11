//
//  MFBase64.h
//  yylove
//
//  Created by lovis on 2018/5/26.
//

#import <Foundation/Foundation.h>

@interface MFBase64 : NSObject

+(NSString*)base64EncodeData:(NSData*)data;
+(NSString*)base64EncodeString:(NSString*)string;

+(NSString*)base64DecodeString:(NSString*)base64;
+(NSData*)base64DecodeData:(NSString*)base64;

@end
