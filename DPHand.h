//
//  DPHand.h
//  Blackjack
//
//  Created by David Parker on 11/25/14.
//  Copyright (c) 2014 David Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "DPCard.h"

@interface DPHand : NSObject

//properties
@property (nonatomic) NSMutableArray* cards;
@property (nonatomic) int bet;
@property (nonatomic) Boolean firstTurn;

//methods
-(id) initWithBet:(int) betIn;
-(NSString*) description;
-(void) addCard:(DPCard*) toAdd;
-(DPCard*) getAndRemoveSecondCard; //For splitting
-(int) getHandValue;

@end
