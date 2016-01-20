//
//  ViewController.h
//  UIVVTextField
//
//  Created by Vinod Vishwakarma on 26/10/15.
//  Copyright © 2015 Vinod Vishwakarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIVVTextField.h"
#import "UIVVTextView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIVVTextField *nameField;
@property (weak, nonatomic) IBOutlet UIVVTextField *MobileField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIVVTextView *aboutTextView;


- (void) saveDataInContext:(void(^)(NSManagedObjectContext *context))saveBlock;


- (void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion;

- (void)saveDataInBackgroundWithSuccessContext:(void(^)(NSManagedObjectContext *context))saveBlock onSuccess:(void(^)(NSString *result))success onFailure:(void(^)(NSError *error))failure;

@end

