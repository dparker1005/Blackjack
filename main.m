//
//  main.m
//  Blackjack
//
//  Created by David Parker on 11/21/14.
//  Copyright (c) 2014 David Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPCard.h"
#import "DPHand.h"
#import "DPDeck.h"

int main(int argc, const char * argv[]) {
    
    DPDeck* deck = [[DPDeck alloc]init];

    int playerBalance = 1000;
    
    //-------------------------------------------------------------------------------
    
    //START GAME LOOP
    while (playerBalance > 0) {
        
        //ASK FOR BET
        int bet = -1;
        while (bet<=0 || bet>playerBalance) {
            printf("You have $%d. How much would you like to bet on this hand?\n",playerBalance);
            scanf("%i", &bet);
            printf("\n");
        }
        
        NSMutableArray* playerHands = [[NSMutableArray alloc]init];
        
        //DEAL INITIAL CARDS
        DPHand* playerHand = [[DPHand alloc]initWithBet:bet];
        DPHand* computerHand = [[DPHand alloc]initWithBet:-1];
     
        DPCard* tempCard = [deck getRandomCard];
        [playerHand addCard:tempCard];
        
        tempCard = [deck getRandomCard];
        [playerHand addCard:tempCard];
        [playerHands addObject:playerHand];
        
        tempCard = [deck getRandomCard];
        [computerHand addCard:tempCard];
        
        DPCard*computerSecondCard = [deck getRandomCard];
        
        //---------------------------------------------------------------------------
        
        int handIndex = 0;
        while (handIndex<[playerHands count]) {
            printf("Dealer's Hand:\n%s",[[computerHand description] cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("Your Hand:\n%s",[[playerHands[handIndex] description] cStringUsingEncoding:NSUTF8StringEncoding]);
            
            //PROMPT USER FOR INPUT UNTIL TURN COMPLETE (0=stand, 1=hit, 2=double if first time, 3=split if there are identical cards, etc.)
            int userInput = -1;
            Boolean noNextTurn = false;
            while ((userInput != 0 ) && [playerHands[handIndex] getHandValue]<=21 && noNextTurn == false)
            {
                if (((DPHand*)playerHands[handIndex]).firstTurn == true &&
                    [((DPHand*)playerHands[handIndex]).cards count] == 2 &&
                    ((DPCard*)((DPHand*)playerHands[handIndex]).cards[0]).face == ((DPCard*)((DPHand*)playerHands[handIndex]).cards[1]).face&& ((DPHand*)playerHands[handIndex]).bet*2<=playerBalance) {
                    printf("What would you like to do?\n0=Stand\n1=Hit\n2=Double Down\n3=Split\n");
                }
                else if (((DPHand*)playerHands[handIndex]).firstTurn && ((DPHand*)playerHands[handIndex]).bet*2<=playerBalance) {
                    printf("What would you like to do?\n0=Stand\n1=Hit\n2=Double Down\n");
                }
                else{
                    printf("What would you like to do?\n0=Stand\n1=Hit\n");
                }
                scanf("%i", &userInput);
                //hit
                if (userInput == 1) {
                    ((DPHand*)playerHands[handIndex]).firstTurn = false;
                    tempCard = [deck getRandomCard];
                    printf("\nYou got the %s",[[tempCard description] cStringUsingEncoding:NSUTF8StringEncoding]);
                    [playerHands[handIndex] addCard:tempCard];
                    printf("\nYour Hand:\n%s",[[playerHands[handIndex] description] cStringUsingEncoding:NSUTF8StringEncoding]);
                    if ([playerHands[handIndex] getHandValue]>21) {
                        printf("\nYou went over 21.\n");
                    }
                }
                //double
                else if (userInput == 2 && ((DPHand*)playerHands[handIndex]).firstTurn && ((DPHand*)playerHands[handIndex]).bet*2<=playerBalance){
                    ((DPHand*)playerHands[handIndex]).firstTurn = false;
                    noNextTurn = true;
                    ((DPHand*)playerHands[handIndex]).bet *= 2;
                    tempCard = [deck getRandomCard];
                    printf("\nYou got the %s",[[tempCard description] cStringUsingEncoding:NSUTF8StringEncoding]);
                    [playerHands[handIndex] addCard:tempCard];
                    printf("\nYour Hand:\n%s",[[playerHands[handIndex] description] cStringUsingEncoding:NSUTF8StringEncoding]);
                    if ([playerHands[handIndex] getHandValue]>21) {
                        printf("\nYou went over 21.\n");
                    }
                }
                //split
                else if (((DPHand*)playerHands[handIndex]).firstTurn == true &&
                         [((DPHand*)playerHands[handIndex]).cards count] == 2 &&
                         ((DPCard*)((DPHand*)playerHands[handIndex]).cards[0]).face == ((DPCard*)((DPHand*)playerHands[handIndex]).cards[1]).face && ((DPHand*)playerHands[handIndex]).bet*2<=playerBalance) {
                    DPCard* cardForSecondHand =[(DPHand*)playerHands[handIndex] getAndRemoveSecondCard];
                    DPHand* newHand = [[DPHand alloc]initWithBet:((DPHand*)playerHands[handIndex]).bet];
                    
                    //adding new card to first hand
                    tempCard = [deck getRandomCard];
                    [playerHands[handIndex] addCard:tempCard];
                    
                    //adding cards to new hand
                    [newHand addCard:cardForSecondHand];
                    tempCard = [deck getRandomCard];
                    [newHand addCard:tempCard];
                    [playerHands addObject:newHand];
                    
                    printf("\nOne of Your Hands:\n%s",[[playerHands[handIndex] description] cStringUsingEncoding:NSUTF8StringEncoding]);
                    printf("\nAnother One of Your Hands:\n%s\n\n\n",[[newHand description] cStringUsingEncoding:NSUTF8StringEncoding]);
                    
                    printf("Dealer's Hand:\n%s",[[computerHand description] cStringUsingEncoding:NSUTF8StringEncoding]);
                    printf("Your Hand:\n%s",[[playerHands[handIndex] description] cStringUsingEncoding:NSUTF8StringEncoding]);
                }

                
            }
            handIndex++;
        }
        
        //---------------------------------------------------------------------------
        
        //COMPLETE COMPUTER TURN
        [computerHand addCard:computerSecondCard];
        printf("\nDealer's Hand:\n%s",[[computerHand description] cStringUsingEncoding:NSUTF8StringEncoding]);
        if ([playerHand getHandValue]<=21) {
            while ([computerHand getHandValue]<17) {
                tempCard = [deck getRandomCard];
                printf("\nThe dealer got the %s",[[tempCard description] cStringUsingEncoding:NSUTF8StringEncoding]);
                [computerHand addCard:tempCard];
                printf("\nDealer's Hand:\n%s",[[computerHand description] cStringUsingEncoding:NSUTF8StringEncoding]);
                if ([computerHand getHandValue]>21) {
                    printf("\nThe dealer went over 21.\n");
                }
                
            }
        }
        
        //---------------------------------------------------------------------------
        
        handIndex = 0;
        while (handIndex<[playerHands count]) {
            //DECLARE WINNER AND CHANGE BALANCE
            if ([((DPHand*)playerHands[handIndex]) getHandValue] == 21 && ((DPHand*)playerHands[handIndex]).firstTurn && [computerHand getHandValue] != 21) {
                playerBalance += ((DPHand*)playerHands[handIndex]).bet*1.5;
                printf("BLACKJACK!!! You Win! Your new balance is $%d.\n",playerBalance);
            }
            else if ([((DPHand*)playerHands[handIndex]) getHandValue]>21) {
                playerBalance -= ((DPHand*)playerHands[handIndex]).bet;
                printf("You lose. Your new balance is $%d.\n",playerBalance);
            }
            else if ([computerHand getHandValue]>21){
                playerBalance += ((DPHand*)playerHands[handIndex]).bet;
                printf("You win. Your new balance is $%d.\n",playerBalance);
            }
            else if ([computerHand getHandValue] == [((DPHand*)playerHands[handIndex]) getHandValue]){
                printf("This hand was a push.\n");
            }
            else if ([computerHand getHandValue] > [((DPHand*)playerHands[handIndex]) getHandValue]){
                playerBalance -= ((DPHand*)playerHands[handIndex]).bet;
                printf("You lose. Your new balance is $%d.\n",playerBalance);
            }
            else if ([computerHand getHandValue] < [((DPHand*)playerHands[handIndex]) getHandValue]){
                playerBalance += ((DPHand*)playerHands[handIndex]).bet;
                printf("You win. Your new balance is $%d.\n",playerBalance);
            }
            handIndex++;
        }
        //END GAME LOOP
        printf("\n\n----------------------------\n\n\n");
    }
    printf("You have ran out of money. Better Luck next time!!!");
    return 0;
}
