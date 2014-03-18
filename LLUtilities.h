//
//  LLUtilities.h
//  LinkedList
//
//  Created by Nathan Wood on 3/03/2014.
//  Copyright (c) 2014 Nathan Wood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLItem.h"

@interface LLUtilities : NSObject

/**
 *  Sorts a linked list using merge sort comparing using the comparator
 *  http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.html
 *
 *  Make sure to capture the return value as the new head of the list
 *
 *  @param list       The head of the list to sort
 *  @param comparator The comparator block to compare elements
 *
 *  @return The new head of the sorted list
 */
+ (id)mergeSortList:(id <LLItem>)list comparator:(NSComparator)comparator;

@end
