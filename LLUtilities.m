//
//  LLUtilities.m
//  LinkedList
//
//  Created by Nathan Wood on 3/03/2014.
//  Copyright (c) 2014 Nathan Wood. All rights reserved.
//

#import "LLUtilities.h"
#import "Number.h"

@implementation LLUtilities

/**
 *  http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.c
 */
+ (id)mergeSortList:(id <LLItem>)list comparator:(NSComparator)comparator
{
    if (list == nil)
        return nil;
    
    NSAssert([list conformsToProtocol:@protocol(LLDItem)] == NO, @"Doubly linked list is unsupported at the moment");
    
    id <LLItem> oldhead;
    id <LLItem> tail;
    id <LLItem> p, q, e; // Sub-lists
    NSInteger psize, qsize;
    
    NSInteger insize = 1;
    
    while (YES)
    {
        p = list;
        oldhead = list;
        list = nil;
        tail = nil;
        
        NSUInteger nmerges = 0;
        while (p != nil)
        {
            nmerges++;
            
            q = p;
            psize = 0;
            for (NSInteger i = 0; i < insize; i++)
            {
                psize++;
                q = [q nextObject];
                if (q == nil)
                    break;
            }
            
            qsize = insize;
            
            while (psize > 0 || (qsize > 0 && q != nil))
            {
                /* decide whether next element of merge comes from p or q */
                if (psize == 0)
                {
                    /* p is empty; e must come from q. */
                    e = q; q = [q nextObject]; qsize--;
                    if (q == oldhead)
                        q = nil;
                }
                else if (qsize == 0 || q == nil)
                {
                    /* q is empty; e must come from p. */
                    e = p; p = [p nextObject]; psize--;
                    if (p == oldhead)
                        p = nil;
                }
                else if (comparator(p, q) <= NSOrderedSame)
                {
                    /* First element of p is lower (or same);
                     * e must come from p. */
                    e = p; p = [p nextObject]; psize--;
                    if (p == oldhead)
                        p = nil;
                }
                else
                {
                    /* First element of q is lower; e must come from q. */
                    e = q; q = [q nextObject]; qsize--;
                    if (q == oldhead)
                        q = nil;
                }
                
                if (tail)
                    [tail addObject:e];
                else
                    list = e;
                
                tail = e;
            }
            
            p = q;
        }
        
        [tail addObject:nil];
        
        if (nmerges <= 1)
            return list;
        
        insize *= 2;
    }
}

@end
