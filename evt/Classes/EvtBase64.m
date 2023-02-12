//
//  EvtBase64.m
//
//  Created by lovis on 2018/5/26.
//

#import "EvtBase64.h"

@implementation EvtBase64

+ (NSData *)base64DecodeData:(NSString *)base64 { 
    return [[NSData alloc]initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

+ (NSString *)base64DecodeString:(NSString *)base64 {
    NSData* data = [[NSData alloc]initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)base64EncodeString:(NSString *)string {
    return [[string dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}

+ (NSString *)base64EncodeData:(NSData *)data {
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
