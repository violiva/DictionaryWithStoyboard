//
//  VOSWordsTableViewController.h
//  VOSDiccionarioiPadBasico
//
//  Created by Vicente Oliva de la Serna on 20/1/15.
//  Copyright (c) 2015 Vicente Oliva de la Serna. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VOSWordsModel;
@class VOSWordsTableViewController;

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WORD_KEY @"lastword"

@protocol wordsTableViewControllerDelegate <NSObject>

-(void) wordsTableViewController:(VOSWordsTableViewController *) dictVC didSelectWord:(NSString *) aWord;

@end

@interface VOSWordsTableViewController : UITableViewController

@property (weak, nonatomic) id<wordsTableViewControllerDelegate> delegate;
@property (strong, nonatomic) VOSWordsModel * model;


@end
