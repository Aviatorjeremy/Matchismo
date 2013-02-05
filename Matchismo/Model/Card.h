//
//  Card.h
//  Matchismo
//
//  Created by 龚 睿博 on 2/1/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
