//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by 龚 睿博 on 2/2/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray *cards;
@property (strong,nonatomic) NSMutableArray *flippedCards;
@property (nonatomic) int score;
@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)flippedCards
{
    if (!_flippedCards) {
        _flippedCards = [[NSMutableArray alloc] init];
    }
    return _flippedCards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (void)flipCardAtIndex2:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [self.flippedCards addObject:otherCard];
                    if (self.flippedCards.count>1)
                    {
                    int matchScore = [card match:self.flippedCards];
                    Card *flippedCard1 = self.flippedCards[self.flippedCards.count-2];
                    Card *flippedCard2 = self.flippedCards[self.flippedCards.count-1];
                    if (matchScore) {
                        flippedCard1.unplayable = YES;
                        flippedCard2.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        //[self.flippedCards removeAllObjects];
                    }else{
                        flippedCard1.faceUp = NO;
                        flippedCard2.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        //[self.flippedCards removeAllObjects];
                    }
                    
                    break;
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        [self.flippedCards removeAllObjects];
        card.faceUp = !card.isFaceUp;
    }
}

@end
