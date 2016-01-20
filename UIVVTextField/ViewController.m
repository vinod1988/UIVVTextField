//
//  ViewController.m
//  UIVVTextField
//
//  Created by Vinod Vishwakarma on 26/10/15.
//  Copyright © 2015 Vinod Vishwakarma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIVVTextViewDelegate>

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.nameField setLimit:50];
    [self.MobileField setLimit:10];
    
    
    
    self.aboutTextView.layer.borderWidth = 0.5;
    self.aboutTextView.layer.cornerRadius = 3;
    self.aboutTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.aboutTextView.delegate = self;
    [self.aboutTextView setLimit:22];
    
    [self saveDataInContext:^(NSManagedObjectContext *context) {
        
    }];
    
    [self saveDataInBackgroundWithContext:^(NSManagedObjectContext *context) {
        
    } completion:^{
        
    }];
    
    [self saveDataInBackgroundWithSuccessContext:^(NSManagedObjectContext *context) {
        
    } onSuccess:^(NSString *result) {
        
    } onFailure:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonAction:(id)sender {
    
    [self shakeLabel];
}


-(void)shakeLabel {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(self.passwordField.center.x - 5,self.passwordField.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(self.passwordField.center.x + 5, self.passwordField.center.y)]];
    [self.passwordField.layer addAnimation:shake forKey:@"position"];
}


- (void) saveDataInContext:(void(^)(NSManagedObjectContext *context))saveBlock {

}


- (void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion {
}

- (void)saveDataInBackgroundWithSuccessContext:(void(^)(NSManagedObjectContext *context))saveBlock onSuccess:(void(^)(NSString *result))success onFailure:(void(^)(NSError *error))failure {

}


- (void)textViewLimit:(UIVVTextView *)textViewLimit didWentOverLimitWithDisallowedText:(NSString *)text inDisallowedRange:(NSRange)range {

}

- (void)textViewLimit:(UIVVTextView *)textViewLimit didReachLimitWithLastEnteredText:(NSString *)text inRange:(NSRange)range {

}




@end
