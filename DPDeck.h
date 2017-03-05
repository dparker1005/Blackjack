//
//  DPDeck.h
//  Blackjack
//
//  Created by David Parker on 12/8/14.
//  Copyright (c) 2014 David Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPHand.h"
#import "DPCard.h"

@interface DPDeck : NSObject

//properties
@property (nonatomic) NSMutableArray* cardsInDeck;

//methods
-(id) init;
-(NSString*) description;
-(void) shuffle;
-(DPCard*) getRandomCard;

@end
