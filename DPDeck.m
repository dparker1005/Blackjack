//
//  DPDeck.m
//  Blackjack
//
//  Created by David Parker on 12/8/14.
//  Copyright (c) 2014 David Parker. All rights reserved.
//

#import "DPDeck.h"

@implementation DPDeck

-(id) init
{
    self = [super init];
    if(!self) return nil;
    
    [self shuffle];
    return self;
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"The deck has %lu cards in it.",[self.cardsInDeck count]];
}

-(void) shuffle
{
    //clear deck
    self.cardsInDeck = [[NSMutableArray alloc]init];
    
    //fill deck
    for (int n = 1; n<=13; n++) {
        
        //switch the index to the card face
        NSString* cardFace = @"";
        switch (n) {
            case 1:
                cardFace = @"ace";
                break;
            case 2:
                cardFace = @"2";
                break;
            case 3:
                cardFace = @"3";
                break;
            case 4:
                cardFace = @"4";
                break;
            case 5:
                cardFace = @"5";
                break;
            case 6:
                cardFace = @"6";
                break;
            case 7:
                cardFace = @"7";
                break;
            case 8:
                cardFace = @"8";
                break;
            case 9:
                cardFace = @"9";
                break;
            case 10:
                cardFace = @"10";
                break;
            case 11:
                cardFace = @"jack";
                break;
            case 12:
                cardFace = @"queen";
                break;
            case 13:
                cardFace = @"king";
                break;
                
            default:
                break;
        }
        
        //add the cards to the deck
        [self.cardsInDeck addObject:[[DPCard alloc]initWithFace:cardFace Suit:@"hearts"]];
        [self.cardsInDeck addObject:[[DPCard alloc]initWithFace:cardFace Suit:@"spades"]];
        [self.cardsInDeck addObject:[[DPCard alloc]initWithFace:cardFace Suit:@"clubs"]];
        [self.cardsInDeck addObject:[[DPCard alloc]initWithFace:cardFace Suit:@"diamonds"]];
    }

}
-(DPCard*) getRandomCard
{
    DPCard* tempCard = self.cardsInDeck[arc4random()%[self.cardsInDeck count]];
    [self.cardsInDeck removeObjectIdenticalTo:tempCard];
    if([self.cardsInDeck count]==0)
    {
        [self shuffle];
        printf("\n\nShuffling...\n\n");
    }
    
    return tempCard;
}

@end
