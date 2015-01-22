//
//  VOSWordsModel.h
//  VOSDiccionarioiPadBasico
//
//  Created by Vicente Oliva de la Serna on 20/1/15.
//  Copyright (c) 2015 Vicente Oliva de la Serna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOSWordsModel : NSObject

@property (strong) NSDictionary * words;

-(NSArray *) letters;
-(NSString *) letterAtIndex: (NSInteger) aLetterIndex;


-(NSArray *) wordsThatStartWithLetter:(NSString *) aLetter;
-(NSString *) wordThatStartWithLetter:(NSString *) aLetter atIndex:(NSUInteger) anIndex;
-(NSString *) wordAtIndex:(NSInteger) aWordIndex
          inLetterAtIndex:(NSInteger) aLetterIndex;


@end
