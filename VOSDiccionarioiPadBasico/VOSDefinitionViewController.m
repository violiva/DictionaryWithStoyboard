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

-(id) initWithModel:(NSString *) model{
    if (self = [super init]){
        _wordPass = model;
        self.title = model;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.wordReceived.text = aWord;
    self.title = aWord;
    
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
