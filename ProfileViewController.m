//
//  ProfileViewController.m
//  LibraryClub
//
//  Created by James Rochabrun on 31-03-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "Book.h"


@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property NSManagedObjectContext *moc;
@property NSMutableArray *books;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //here we set the name of the titile from the object that was passed by the MemberSelectedviewController
    self.title = self.member.name;
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    self.books = [NSMutableArray new];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    Book *book = [self.books objectAtIndex:indexPath.row];
    cell.textLabel.text = book.name;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}



//getting new books through the textField
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.moc];
  
    //step 1 after set the relationships
      //beacuse now we are setting a relation from book to member
        //we grab the method from the Member+CoreDataProperties.h
    [book addMembersObject:self.member];
    
    book.name = textField.text;
    
    NSError *error;
    
    if([self.moc save:&error]){
        [self.books addObject:book];
        [self.tableView reloadData];
    }else{
        NSLog(@"an error has occurred,...%@", error);
    }
    
    //keyboard staff
    textField.text = nil;
    return [textField resignFirstResponder];
}



- (void)viewWillAppear:(BOOL)animated {
    
    
    //step 2 now we show all objects from the relationship and pass it to self.books
    //we put this in this view because the textfield is here, we can put it in other Vc if this vc contained a independent VC with a textField
    
    self.books = [[self.member.books allObjects] mutableCopy] ;
    [self.tableView reloadData];
}














@end
