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
    
    // buscamos la palabra con la que queremos arrancar la primera vez
//    NSString * word = [_model wordAtIndex:0 inLetterAtIndex:1];
    NSIndexPath * indexPath = [self coordslastSelectedWord];
    NSString * word = [self.model wordAtIndex:indexPath.row
                              inLetterAtIndex:indexPath.section];
  
    
    // pasamos la palabra al delegado
    [self.delegate wordsTableViewController:self didSelectWord:word];
    
   
    
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

    // Guardamos la palabra seleccionada para que cuando arranque la próxima vez la aplicación comience con la última palabra seleccionada.
    

    [self saveLastSelectedWordAtSection:indexPath.section
                                    row:indexPath.row];

    [self.delegate wordsTableViewController:self
                              didSelectWord:word];
    
}


#pragma mark -  NSUserDefaults
-(NSIndexPath *)coordslastSelectedWord{
    NSDictionary * coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WORD_KEY];
    if (coords == nil){
        coords = [self setDefaults];
    }
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey:@"row"] integerValue]
                                                 inSection:[[coords objectForKey:@"section"] integerValue]];
    
    return indexPath;
}

-(NSDictionary *)setDefaults{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * defaultWordCoords = @{SECTION_KEY:@0, ROW_KEY:@0};
    
    [defaults setObject:defaultWordCoords
                 forKey:LAST_WORD_KEY];
    
    return defaultWordCoords;
    
}


- (void)saveLastSelectedWordAtSection:(NSUInteger)section row:(NSUInteger)row{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{SECTION_KEY : @(section),
                          ROW_KEY     : @(row)}
                 forKey:LAST_WORD_KEY];
    
    [defaults synchronize]; // Por si acaso, que Murphy acecha.
}

- (NSString *)lastSelectedWord
{
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WORD_KEY];
    
    if (coords == nil) {
        // No hay nada bajo la clave LAST_WORD_KEY.
        // Esto quiere decir que es la primera vez que se llama a la App
        // Ponemos un valor por defecto: la primera palabra de la primera sección ( letra A )
        coords = [self setDefaults];
    }else{
        // Ya hay algo, es decir, en algún momento se guardó.
        // No hay nada en especial que hacer.
    }
    
    // Transformamos esas coordenadas en un indexpath
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey: ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey: SECTION_KEY] integerValue]];
    
    // devolvemos la palabra en cuestión
    return [self.model wordAtIndex:indexPath.row inLetterAtIndex:indexPath.section ];
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
