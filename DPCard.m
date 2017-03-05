//
//  DPCard.m
//  Blackjack
//
//  Created by David Parker on 11/21/14.
//  Copyright (c) 2014 David Parker. All rights reserved.
//

#import "DPCard.h"

@implementation DPCard

-(id) initWithFace:(NSString*) face
              Suit:(NSString*) suit
{
    self = [super init];
    if(!self) return nil;
    
    self.face = [face copy];
    self.suit = [suit copy];
    
    return self;
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ of %@",self.face, self.suit];
}

-(int) getValue
{
    //if the face is an ace
    if([self.face isEqualToString:@"ace"]){return 1;}
    
    //if the face is a non-number
    if([self.face isEqualToString:@"king"]||[self.face isEqualToString:@"queen"]||[self.face isEqualToString:@"jack"]){
        return 10;
    }
    
    //if the face is a number
    return [self.face intValue];
    }

@end
