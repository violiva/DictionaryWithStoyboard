//
//  VOSDefinitionViewController.m
//  VOSDiccionarioiPadBasico
//
//  Created by Vicente Oliva de la Serna on 20/1/15.
//  Copyright (c) 2015 Vicente Oliva de la Serna. All rights reserved.
//

#import "VOSDefinitionViewController.h"

@interface VOSDefinitionViewController ()

@end


@implementation VOSDefinitionViewController

// @synthesize wordPass;


-(id) initWithModel:(NSString *) model{
    if (self = [super init]){
        _wordPass = model;
        self.title = model;
        
    }
    return self;
}

#pragma mark - UIWebViewDelegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.browser loadRequest:[self definitionRequestForWord:[self wordPass]]];

}

-(void) webViewDidFinishLoad:(UIWebView *) webView{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{      // aqui ya existe la vista y tiene tamaño correcto
    [super viewWillAppear:animated];
    
    // Asignamos el delegado
    self.browser.delegate = self;
    
    [self.activityView startAnimating];
    [self.activityView setHidden:NO];
    
}

-(NSURLRequest *) definitionRequestForWord: (NSString *) aWord{
    NSURL *url = [NSURL URLWithString:
                  [NSString stringWithFormat:@"http://www.merriam-webster.com/dictionary/%@", aWord]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

#pragma mark - splitViewControllerDelegate
-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        
        // Hay que poner el botón en mi barra de navegación
        self.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
        
    }else if (displayMode == UISplitViewControllerDisplayModeAllVisible){
        
        // Hay que quitar el botón de la barra de navegación
        self.navigationItem.rightBarButtonItem = nil;
    }

}

#pragma mark - wordsTableViewControllerDelegate
-(void) wordsTableViewController:(VOSWordsTableViewController *) dictVC didSelectWord:(NSString *) aWord{
    self.wordPass = aWord;
    self.title = self.wordPass;  // aWord;

    [self.activityView startAnimating];
    [self.activityView setHidden:NO];

    [self.browser loadRequest:[self definitionRequestForWord:self.wordPass ]];

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
