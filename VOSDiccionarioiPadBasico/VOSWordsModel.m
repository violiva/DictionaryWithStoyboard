//
//  VOSWordsModel.m
//  VOSDiccionarioiPadBasico
//
//  Created by Vicente Oliva de la Serna on 20/1/15.
//  Copyright (c) 2015 Vicente Oliva de la Serna. All rights reserved.
//

#import "VOSWordsModel.h"

@implementation VOSWordsModel

-(id)init{
    if( self = [super init]){
        
        NSURL * urlToFile = [[NSBundle mainBundle] URLForResource:@"vocabwords"
                                                    withExtension:@"txt"];
        
        _words = [NSDictionary dictionaryWithContentsOfURL:urlToFile];
        
    }
    return self;
}

#pragma mark - Utils
-(NSArray *) letters{
    
    return [[self.words allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSString *) letterAtIndex: (NSInteger) aLetterIndex{
    return [[self letters] objectAtIndex:aLetterIndex];
}


-(NSArray *) wordsThatStartWithLetter:(NSString *) aLetter{
    
    return [[self.words objectForKey:aLetter] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
}


-(NSString *) wordThatStartWithLetter:(NSString *) aLetter atIndex:(NSUInteger) anIndex{
    
    return [[self wordsThatStartWithLetter:aLetter] objectAtIndex:anIndex];
    
}

-(NSString *) wordAtIndex:(NSInteger) aWordIndex
          inLetterAtIndex:(NSInteger) aLetterIndex{
    
    NSString * letter = [self letterAtIndex:aLetterIndex];
    NSArray * wordsThatStartWithLetter = [self.words objectForKey:letter];
    return [wordsThatStartWithLetter objectAtIndex:aWordIndex];
}

@end
