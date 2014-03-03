//
//  LLItem.h
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

#import <Foundation/Foundation.h>

/**
 *  This protocol is the bare minimum requirements for a linked list item
 */
@protocol LLItem <NSObject>

/**
 *  The next object in the list
 *
 *  @return The next object in the list conforming to LLItem, or nil if there are no more items
 */
- (id)nextObject;

/**
 *  Inserts the specified object after this object in the list
 *
 *  @param object The object to insert after this object
 *
 *  @return The object that was inserted conforming to LLItem
 */
- (id)addObject:(id)object;

@optional

- (NSComparisonResult)compare:(id <LLItem>)item;

@end


/**
 *  This protocol is the bare minimum requirements for a doubly-linked list item
 */
@protocol LLDItem <LLItem>

/**
 *  The previous object in the list
 *
 *  @return The previous object in the list conforming to LLItem, or nil if there are no more previous items
 */
- (id)previousObject;

/**
 *  Inserts the specified object before this object in the list
 *
 *  @param object The object to insert ahead of this object
 *
 *  @return The object that was inserted conforming to LLDItem
 */
- (id)insertObject:(id)object;

@optional

- (NSComparisonResult)compare:(id <LLDItem>)item;

@end


/**
 *  A linked list "virtual" class implementing the LLItem protocol
 */
@interface LLItem : NSEnumerator <LLItem, NSFastEnumeration> {
  @protected
    LLItem *_ll_next;
}

/**
 *  Iterates forwards through the list until the tail (last object) is encountered
 *
 *  @return The tail (last object) of the list
 */
- (id <LLItem>)tail;

/**
 *  Inserts the specified object after the tail (last object) of the list
 *
 *  @param object The object to insert after the list tail (last object)
 *
 *  @return The object that was appeneded to the list, and the new tail of the list
 */
- (id <LLItem>)appendObjectToList:(LLItem *)object;

@end


/**
 *  A doubly-linked list "virtual" class implementing the LLItem protocol
 */
@interface LLDItem : LLItem <LLDItem> {
  @protected
    __unsafe_unretained LLDItem *_ll_prev;
}

/**
 *  Iterates backwards through the list until the head (first object) is encountered
 *
 *  @return The head (first object) of the list
 */
- (id <LLDItem>)head;

/**
 *  Inserts the specified object before the head (first object) of the list
 *
 *  @param object The object to insert before the list head
 *
 *  @return The object that was prepended to the list, and also the new head
 */
- (id <LLDItem>)prependObjectToList:(LLDItem *)object;

@end

@interface LLItem (Predicate)

- (NSArray *)filteredListUsingPredicate:(NSPredicate *)predicate;

@end
