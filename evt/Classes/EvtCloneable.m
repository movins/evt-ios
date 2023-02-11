//
//  MFCloneable.m
//  yylove
//
//  Created by lovis on 2018/5/21.
//

#import "MFCloneable.h"
#import <objc/runtime.h>

@implementation MFCloneable

static NSMutableSet* _properties = nil;

+ (NSSet *)properties
{
    if (!_properties) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _properties = [NSMutableSet set];
            unsigned int outCount, i;
            objc_property_t *props = class_copyPropertyList([self class], &outCount);
            
            for (i=0; i<outCount; i++) {
                objc_property_t property = props[i];
                NSString * key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
                Class cls = [self className:key];
                [_properties addObject:@{@"name":key,@"class":(cls ? cls : [NSNull null])}];
            }
            if (props) {
                free(props);
            }
        });
    }
    return _properties;
}

+(Class)className:(NSString*) name
{
    Class propertyClass = Nil;
    objc_property_t property = class_getProperty([self class], [name UTF8String]);
    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
    
    if (splitPropertyAttributes.count > 0) {
        NSString *encodeType = splitPropertyAttributes[0];
        
        NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
        if (splitEncodeType.count > 1) {
            NSString *className = splitEncodeType[1];
            propertyClass = NSClassFromString(className);
        }
    }
    return propertyClass;
}

-(id)clone
{
    Class cls = self.class;
    id result = [[cls alloc]init];
    NSSet *keys = [self.class properties];
    for (NSDictionary *dic in keys) {
        NSString *name = dic[@"name"];
        id value = [self valueForKey:name];
        [result setValue: (value?value:[NSNull null]) forKey:name];
    }
    
    return result;
}

-(void)clear
{
    Class cls = self.class;
    id object = [[cls alloc]init];
    NSSet *keys = [self.class properties];
    for (NSDictionary *dic in keys) {
        NSString *name = dic[@"name"];
        id value = [object valueForKey:name];
        [self setValue: (value?value:[NSNull null]) forKey:name];
    }
}

-(bool)same:(MFCloneable*)obj
{
    bool result = false;
    do {
        if (![obj.class isEqual:self.class]) break;
        NSSet *keys = [self.class properties];
        for (NSDictionary *dic in keys) {
            NSString *name = dic[@"name"];
            id value = [self valueForKey:name];
            id other = [obj valueForKey:name];
            
            if ([value isKindOfClass:MFCloneable.class] && ![value same:obj]) {
                result = true;
                break;
            } else if ([value isKindOfClass:NSObject.class] && ![value isEqual:other]) {
                result = true;
                break;
            } else if (value != other) {
                result = true;
                break;
            }
        }
    }while (false);

    return result;
}
@end
