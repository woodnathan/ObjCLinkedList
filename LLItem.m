//
//  LLItem.m
//  LinkedList
//
//  Created by Nathan Wood on 7/03/13.
//  Copyright (c) 2013 Nathan Wood. All rights reserved.
//

#import "LLItem.h"

@implementation LLItem

- (id)nextObject
{
    return self->_ll_next;
}

- (id)tail
{
    LLItem *item = self;
    while (item->_ll_next != nil)
        item = item->_ll_next;
    return item;
}

- (id)insertObjectAfter:(LLItem *)object
{
    object->_ll_next = self->_ll_next;
    self->_ll_next = object;
    return object;
}

- (id)appendObjectToList:(LLDItem *)object
{
    return [[self tail] insertObjectAfter:object];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
    NSUInteger c = 0;
    LLItem *item = (__bridge LLItem *)(void *)state->mutationsPtr;
    
    if (state->state == 0)
        item = self;
    else
        if (item->_ll_next == nil) // Something else
            return 0;
    
    do {
        buffer[c++] = item;
        if (item->_ll_next)
            item = item->_ll_next;
        else
            break;
    } while (c < len);
    
    state->itemsPtr = buffer;
    state->mutationsPtr = (unsigned long *)(__bridge void *)item;
    state->state = 1;
    
    return c;
}

@end

@implementation LLDItem

- (id)previousObject
{
    return self->_ll_prev;
}

- (id)head
{
    LLDItem *item = self;
    while (item->_ll_prev != nil)
        item = item->_ll_prev;
    return item;
}

- (id)insertObjectBefore:(LLDItem *)object
{
    self->_ll_prev->_ll_next = object; // Set previous object's next to input
    object->_ll_prev = self->_ll_prev; // Set input's previous to previous
    object->_ll_next = self; // Set input's next to self
    self->_ll_prev = object; // Set self's previous to input
    return object;
}

- (id)insertObjectAfter:(LLDItem *)object
{
    if (self->_ll_next)
        ((LLDItem *)self->_ll_next)->_ll_prev = object; // Set next object's previous to input
    object->_ll_next = self->_ll_next; // Set input's next to self's next
    object->_ll_prev = self; // Set input's previous to self
    self->_ll_next = object; // Set self's next to input
    return object;
}

- (id)prependObjectToList:(LLDItem *)object
{
    return [[self head] insertObjectBefore:object];
}

@end

@implementation LLItem (Predicate)

- (NSArray *)filteredListUsingPredicate:(NSPredicate *)predicate
{
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for (LLItem *item in self) {
        if ([predicate evaluateWithObject:item])
            [objects addObject:item];
    }
    return [objects copy];
}

@end