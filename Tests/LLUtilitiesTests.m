//
//  LLUtilitiesTests.m
//  ObjCLinkedList
//
//  Created by Nathan Wood on 18/03/2014.
//
//

#import <XCTest/XCTest.h>
#import "LLNumber.h"
#import "LLUtilities.h"

@interface LLUtilitiesTests : XCTestCase

@end

@implementation LLUtilitiesTests

- (void)testMergeSort
{
    LLNumber *list = [[LLNumber alloc] initWithNumber:@(arc4random())];
    LLNumber *tail = list;
    const NSUInteger count = 100;
    for (int i = 0; i < count; i++)
        tail = [tail addObject:[[LLNumber alloc] initWithNumber:@(arc4random())]];
    
    LLNumber *sorted = [LLUtilities mergeSortList:list
                                       comparator:^NSComparisonResult(id obj1, id obj2) {
                                           return[obj1 compare:obj2];
                                       }];
    
    LLNumber *p = sorted;
    LLNumber *n = [sorted nextObject];
    NSUInteger counted = 0;
    while (n != nil)
    {
        XCTAssert([n compare:p] >= NSOrderedSame, @"The previous object compared to is ascending");
        p = n, n = [n nextObject], counted++;
    }
    XCTAssertEqual(counted, count, @"The number of objects sorted is not equal to the starting list");
}

- (void)testMergeSortDoublyLinkedList
{
    LLDItem *list = [LLDItem new];
    LLDItem *tail = list;
    for (int i = 0; i < 10; i++)
        tail = [tail addObject:[LLDItem new]];
    
    XCTAssertThrows([LLUtilities mergeSortList:list comparator:nil], @"Doubly linked list is unsupported and should throw");
}

@end
