//
//  PlayingLastAction.m
//  Matchismo
//
//  Created by 龚 睿博 on 2/4/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import "PlayingLastAction.h"

@interface PlayingLastAction()
@property (nonatomic) NSString *outPutString;
@end

@implementation PlayingLastAction

@synthesize flipCard=_flipCard;

- (void)setFlipCard:(Card *)flipCard
{
    if (flipCard) {
        _flipCard = flipCard;
    }
}

- (NSMutableArray *)flipCardAction
{
    if (!_flipCardAction) {
        _flipCardAction = [[NSMutableArray alloc] init];
    }
    return _flipCardAction;
}

- (void)addAction:(PlayingCard *)lastFlipCard
{
    [self.flipCardAction addObject:lastFlipCard];
}

- (void)changeLable
{
    int count = self.flipCardAction.count;
    if (count<2) {
        Card *card = self.flipCardAction[count-1];
        NSString *lastActionString = card.contents;
        self.outPutString = [NSString stringWithFormat:@"Flipped up %@ cost 1 point",lastActionString];
    }else{
        Card *card1 = self.flipCardAction[count-2];
        Card *card2 = self.flipCardAction[count-1];
        int matchScore = [card1 match:@[card2]];
        if (matchScore) {
            self.outPutString = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card1.contents,card2.contents,matchScore*4];
            [self.flipCardAction removeAllObjects];
            //self.lastActionLable.text = [NSString stringWithFormat:@"Flipped up %@",lastActionString];
        }else{
            int penalty = 2;
            self.outPutString = [NSString stringWithFormat:@"%@ and %@ don't match! %d points penalty!",card1.contents,card2.contents,penalty];
        }
    }
}

@end
