//
//  PlayingLastAction.h
//  Matchismo
//
//  Created by 龚 睿博 on 2/4/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "PlayingCard.h"

@interface PlayingLastAction : NSObject

@property (strong,nonatomic) NSMutableArray *flipCardAction;
@property (strong,nonatomic) Card *flipCard;
@property (readonly) NSString *outPutString;
- (void)addAction:(Card *)lastFlipCard;
- (void)changeLable;

@end
