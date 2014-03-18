//
//  LLNumber.h
//  ObjCLinkedList
//
//  Created by Nathan Wood on 18/03/2014.
//
//

#import "LLItem.h"

@interface LLNumber : LLItem

- (instancetype)initWithNumber:(NSNumber *)number;

@property (nonatomic, readonly) NSNumber *number;

@end
