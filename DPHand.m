//
//  DPHand.m
//  Blackjack
//
//  Created by David Parker on 11/25/14.
//  Copyright (c) 2014 David Parker. All rights reserved.
//

#import "DPHand.h"

@implementation DPHand

-(id) initWithBet:(int) betIn;
{
    self = [super init];
    if(!self) return nil;
    
    self.cards = [[NSMutableArray alloc]init];
    self.bet = betIn;
    self.firstTurn = true;
    return self;
}

-(NSString*) description
{
    NSString* cardList = @"";
    
    for (int n = 0; n<[self.cards count]; n++) {
        cardList = [cardList stringByAppendingString:[self.cards[n] description]];
        cardList = [cardList stringByAppendingString:@"\n"];
    }
    if ([self.cards count] == 1) {
        cardList = [cardList stringByAppendingString:@"???\n"];
    }
    
    return [NSString stringWithFormat:@"%@Hand Value: %d\n\n",cardList,[self getHandValue]];
}

-(void) addCard:(DPCard*) toAdd
{
    [self.cards addObject:toAdd];
}

-(DPCard*) getAndRemoveSecondCard
{
    DPCard* tempCard = self.cards[1];
    [self.cards removeObjectAtIndex:1];
    return tempCard;
}

-(int) getHandValue
{
    int handValue = 0;
    Boolean isAceInHand = false;
    
    //looping through hand
    for (int n = 0; n<[self.cards count]; n++) {
        
        //checks for ace
        if ([self.cards[n] getValue] == 1) {
            isAceInHand = true;
        }
        
        handValue += [self.cards[n] getValue];
        
    }
    
    //adding in ace if there was one
    if (handValue <= 11 && isAceInHand == true) {
        handValue+=10;
    }
    
    return handValue;
}

@end
