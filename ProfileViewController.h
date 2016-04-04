//
//  ProfileViewController.h
//  LibraryClub
//
//  Created by James Rochabrun on 31-03-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

@interface ProfileViewController : UIViewController

//creating a property Member to pass the data from the MembersSelectedViewController
@property Member *member;

@end
