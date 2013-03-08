//
//  LLItem.h
//  LinkedList
//
//  Created by Nathan Wood on 7/03/13.
//  Copyright (c) 2013 Nathan Wood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLItem : NSObject <NSFastEnumeration> {
  @protected
    LLItem *_ll_next;
}

/* Accessors */
- (id)nextObject;
- (id)tail;

/* Mutators */
- (id)insertObjectAfter:(LLItem *)object;
- (id)appendObjectToList:(LLItem *)object;

@end

@interface LLDItem : LLItem {
  @protected
    __unsafe_unretained LLDItem *_ll_prev;
}

/* Accessors */
- (id)previousObject;
- (id)head;

/* Mutators */
- (id)insertObjectBefore:(LLDItem *)object;
- (id)prependObjectToList:(LLDItem *)object;

@end

@interface LLItem (Predicate)

- (NSArray *)filteredListUsingPredicate:(NSPredicate *)predicate;

@end