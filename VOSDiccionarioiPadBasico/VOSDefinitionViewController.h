//
//  VOSDefinitionViewController.h
//  VOSDiccionarioiPadBasico
//
//  Created by Vicente Oliva de la Serna on 20/1/15.
//  Copyright (c) 2015 Vicente Oliva de la Serna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VOSWordsTableViewController.h"

@interface VOSDefinitionViewController : UIViewController <UISplitViewControllerDelegate, wordsTableViewControllerDelegate>

@property (strong, nonatomic) NSString * wordPass;

@property (weak, nonatomic) IBOutlet UILabel * wordReceived;


-(id) initWithModel:(NSString *) model;

@end
