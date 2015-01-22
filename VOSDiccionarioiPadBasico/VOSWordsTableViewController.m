//
//  VOSWordsTableViewController.m
//  VOSDiccionarioiPadBasico
//
//  Created by Vicente Oliva de la Serna on 20/1/15.
//  Copyright (c) 2015 Vicente Oliva de la Serna. All rights reserved.
//

#import "VOSWordsTableViewController.h"
#import "VOSDefinitionViewController.h"
#import "VOSWordsModel.h"

////------------------------------------------------------------------------
//// segunda opcion para implementar aquí en lugar de en el appdelegate.
////------------------------------------------------------------------------
// @interface VOSDefinitionViewController()
// @property (strong, nonatomic) VOSDefinitionViewController * definitionViewController;
// @end
////-------------------------------------------------------------------------


@implementation VOSWordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [[VOSWordsModel alloc] init];
    
    //--------------------------------------------------------------------------
    //// segunda opcion para implementar aquí en lugar de en el appdelegate.
    //--------------------------------------------------------------------------
//    self.definitionViewController = [(VOSDefinitionViewController *)[self.splitViewController.viewControllers lastObject] topViewController];
//    self.delegate = self.definitionViewController;
    //---------------------------
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL) animated{
    [super viewWillAppear:animated];
    
    self.title = @"Diccionario";

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[self.model letters] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSString * letter = [[self model] letterAtIndex:section];
    
    return [[[self model] wordsThatStartWithLetter:letter] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if ( cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    
    NSString * word = [self.model wordAtIndex:indexPath.row inLetterAtIndex:indexPath.section];

    cell.textLabel.text = word;
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.model letterAtIndex:section];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * word = [self.model wordAtIndex:indexPath.row inLetterAtIndex:indexPath.section];

    [self.delegate wordsTableViewController:self
                              didSelectWord:word];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *) segue sender:(id) sender {
    // Get the new view controller using [segue destinationViewController].
    if ( [segue.identifier isEqualToString:@"showDefinition"]){
        
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        
        // localizamos la palabra a buscar su definición en la web
        NSString * word = [self.model wordAtIndex:indexPath.row inLetterAtIndex:indexPath.section];

        // identificamos el ViewControler al que se realizará la transición
        VOSDefinitionViewController * destVC = segue.destinationViewController;
        
        // asignamos valores a destino
        destVC.wordPass = word;
        
    }
 
}

@end
