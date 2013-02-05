//
//  PlayingCard.h
//  Matchismo
//
//  Created by 龚 睿博 on 2/2/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
