//
//  VOSDefinitionViewController.h
//  VOSDiccionarioiPadBasico
//
//  Created by Vicente Oliva de la Serna on 20/1/15.
//  Copyright (c) 2015 Vicente Oliva de la Serna. All rights reserved.
//

@class UIKit;
#import "VOSWordsTableViewController.h"

@interface VOSDefinitionViewController : UIViewController <UISplitViewControllerDelegate, wordsTableViewControllerDelegate, UIWebViewDelegate>

@property (copy, nonatomic) NSString * wordPass;
@property (weak, nonatomic) IBOutlet UIWebView * browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityView;

-(NSURLRequest *) definitionRequestForWord: (NSString *) aWord;


-(id) initWithModel:(NSString *) model;

@end
