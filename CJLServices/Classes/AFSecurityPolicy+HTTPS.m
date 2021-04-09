//
//  AFSecurityPolicy+HTTPS.m
//  WAKA
//
//  Created by dev on 2020/8/10.
//  Copyright © 2020 CreditEase. All rights reserved.
//
#ifdef DEBUG
#import "AFSecurityPolicy+HTTPS.h"
#import <objc/runtime.h>
@implementation AFSecurityPolicy (HTTPS)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleDefaultPolicy];
    });
}
+ (instancetype)xxxx_defaultPolicy {
    AFSecurityPolicy *policy = [self xxxx_defaultPolicy];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    return policy;
}


+ (void)swizzleDefaultPolicy {
    Class class = self;
    SEL safeSel = @selector(defaultPolicy);
    SEL unsafeSel = @selector(xxxx_defaultPolicy);
    Method safeMethod = class_getClassMethod(class, safeSel);
    Method unsafeMethod = class_getClassMethod(class, unsafeSel);
    method_exchangeImplementations(unsafeMethod, safeMethod);
}
+ (void)testMethod {
    NSLog(@"******test method*****");
}
@end
#endif
