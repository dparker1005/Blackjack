//
//  DPCard.h
//  Blackjack
//
//  Created by David Parker on 11/21/14.
//  Copyright (c) 2014 David Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPCard : NSObject

//properties
@property (nonatomic) NSString* face;
@property (nonatomic) NSString* suit;

//methods
-(id) initWithFace:(NSString*) face
              Suit:(NSString*) suit;
-(NSString*) description;
-(int) getValue;

@end
