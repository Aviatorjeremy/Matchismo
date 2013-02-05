//
//  Deck.h
//  Matchismo
//
//  Created by 龚 睿博 on 2/2/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
