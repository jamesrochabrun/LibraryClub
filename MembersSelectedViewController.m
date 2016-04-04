//
//  MembersSelectedViewController.m
//  LibraryClub
//
//  Created by James Rochabrun on 31-03-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "MembersSelectedViewController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"


//we import this file beacuse we want to acces to its properties
#import "Member.h"

@interface MembersSelectedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray *members;
@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MembersSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //step1
    //In order to this view gets updated too, wee need to repeat almos all the steps that we did with the MembersViewController
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    self.members = [NSMutableArray new];
}


//step 2
-(void)viewWillAppear:(BOOL)animated
{
    
    //this will load whatever ios in the moc
    [self loadMember];
    [self.tableView reloadData];
    
}

//step 3
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    Member *member = [self.members objectAtIndex:indexPath.row];
    
    cell.textLabel.text = member.name;
    return cell;
    
}

//step 4
-(void)loadMember
{
    
    //here we are fetching the data for the Traveller entity
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Member"];
    
    //    member.selected = [NSNumber numberWithBool:YES];
    
    
    //this is going to filter the data HERE IS WHERE WE DECIDE WHICh USER SHOW
    //IF THE WAS SELECTED AND
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected = YES"];
    request.predicate = predicate;
    //here is where we are populating the array with data from the staging area0
    
    //checking error
    NSError *error;
    
    //the & is using the addres of error
    self.members = [[self.moc executeFetchRequest:request error:&error]mutableCopy];
    if(error == nil){
        [self.tableView reloadData];
    }else{
        NSLog(@"Error: %@", error);
    }
}

//step 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.members.count;
}

////FROM HERE WE WILL IMPLEMENT THE LOGIC FOR THE SEGUE AND PASS THE DATA TO THE BooKviewController


// when segueing from cell to to ProfileVC, pass along Friend object
//////passing data to the ProfileViewController
// when segueing from cell to to ProfileVC, pass along Friend object
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"%li", self.members.count);

    if ([segue.identifier isEqualToString:@"profileVC"]) {

    NSIndexPath *path = [self.tableView indexPathForCell:sender];
    Member *member = [self.members objectAtIndex:path.row];
    
    ProfileViewController *pVC = segue.destinationViewController;
    
    //here we are assigning one item in the members array to the member property of the ProfileViewController
    pVC.member = member;
    }
    
}

















@end
