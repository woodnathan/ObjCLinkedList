//
//  LLNumber.m
//  ObjCLinkedList
//
//  Created by Nathan Wood on 18/03/2014.
//
//

#import "LLNumber.h"

@implementation LLNumber

- (instancetype)initWithNumber:(NSNumber *)number
{
    self = [super init];
    if (self)
    {
        self->_number = number;
    }
    return self;
}

- (NSComparisonResult)compare:(LLNumber *)item
{
    return [self.number compare:item.number];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p, %@>", NSStringFromClass([self class]), self, self.number];
}

@end
