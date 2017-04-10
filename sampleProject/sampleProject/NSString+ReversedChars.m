//
//  NSString+ReversedChars.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/10/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "NSString+ReversedChars.h"

@implementation NSString (ReversedChars)

- (NSArray<NSString *> *)reversedCharactersArray {
    
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    for (NSInteger i = self.length - 1; i >= 0; i--) {
        NSString *singleChar = [self substringWithRange:NSMakeRange(i, 1)];
        [result addObject:singleChar];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
