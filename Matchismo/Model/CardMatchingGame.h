//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by 龚 睿博 on 2/2/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (void)flipCardAtIndex2:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;


@end
