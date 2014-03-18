//
//  LLItem.m
//
//  Copyright (c) 2013 Nathan Wood (http://www.woodnathan.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LLItem.h"

@implementation LLItem

- (id <LLItem>)nextObject
{
    return self->_ll_next;
}

- (id <LLItem>)tail
{
    LLItem *item = self;
    while (item->_ll_next != nil)
        item = item->_ll_next;
    return item;
}

- (id <LLItem>)addObject:(LLItem *)object
{
    if (object != nil)
        object->_ll_next = self->_ll_next;
    self->_ll_next = object;
    
    return object;
}

- (id <LLItem>)appendObjectToList:(LLItem *)object
{
    return [(id <LLItem>)[self tail] addObject:object];
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

- (id <LLDItem>)previousObject
{
    return self->_ll_prev;
}

- (id <LLDItem>)head
{
    LLDItem *item = self;
    while (item->_ll_prev != nil)
        item = item->_ll_prev;
    return item;
}

- (id <LLDItem>)insertObject:(LLDItem *)object
{
    if (self->_ll_prev != nil)
        self->_ll_prev->_ll_next = object; // Set previous object's next to input
    
    if (object != nil)
    {
        object->_ll_prev = self->_ll_prev; // Set input's previous to previous
        object->_ll_next = self; // Set input's next to self
    }
    self->_ll_prev = object; // Set self's previous to input
    
    return object;
}

- (id <LLDItem>)addObject:(LLDItem *)object
{
    if (self->_ll_next != nil)
        ((LLDItem *)self->_ll_next)->_ll_prev = object; // Set next object's previous to input
    
    if (object != nil)
    {
        object->_ll_next = self->_ll_next; // Set input's next to self's next
        object->_ll_prev = self; // Set input's previous to self
    }
    self->_ll_next = object; // Set self's next to input
    
    return object;
}

- (id)prependObjectToList:(LLDItem *)object
{
    return [[self head] insertObject:object];
}

@end

@implementation LLItem (Predicate)

- (NSArray *)filteredListUsingPredicate:(NSPredicate *)predicate
{
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for (LLItem *item in self)
    {
        if ([predicate evaluateWithObject:item])
            [objects addObject:item];
    }
    return [objects copy];
}

@end