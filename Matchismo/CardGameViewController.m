//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 龚 睿博 on 2/1/13.
//  Copyright (c) 2013 龚 睿博. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingLastAction.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) PlayingLastAction *action;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeController;
@property (nonatomic) BOOL isThreeCardMode;
@end

@implementation CardGameViewController



- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

-(PlayingLastAction *)action
{
    if (!_action) {
        _action = [[PlayingLastAction alloc] init];
    }
    return _action;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons=cardButtons;
    [self updateUI];
}

- (void)updateUI
{
       //UIImage *cardBackImage = [UIImage imageNamed:@"backImage.jpg"];
       //UIImage *cardBackImageq = [UIImage imageNamed:@"Default.jpg"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        //[cardButton setImage:cardBackImage forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLable.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}


- (IBAction)flipCard:(UIButton *)sender
{
    self.modeController.enabled = NO;
    if (self.isThreeCardMode) {
        [self.game flipCardAtIndex2:[self.cardButtons indexOfObject:sender]];
    }else{
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        [self.action addAction:[self.game cardAtIndex:[self.cardButtons indexOfObject:sender]]];
        [self.action changeLable];
        self.lastActionLable.text = self.action.outPutString;
    }
    
    self.flipCount++;
    [self updateUI];
}

- (IBAction)loadNewGame:(UIButton *)sender
{
    self.modeController.enabled = YES;
    self.flipCount = 0;
    self.game = nil;
    self.lastActionLable.text = @"";
    [self updateUI];
}
- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    self.isThreeCardMode = !self.isThreeCardMode;
}

@end
