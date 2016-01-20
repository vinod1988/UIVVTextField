//
//  UIVVTextField.h
//  UIVVTextField
//
//  Created by Vinod Vishwakarma on 26/10/15.
//  Copyright © 2015 Vinod Vishwakarma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIVVTextField;

@protocol UIVVTextFieldDelegate<UITextFieldDelegate>

@optional
- (void)textFieldLimit:(UIVVTextField *)textFieldLimit didWentOverLimitWithDisallowedText:(NSString *)text inDisallowedRange:(NSRange)range;
- (void)textFieldLimit:(UIVVTextField *)textFieldLimit didReachLimitWithLastEnteredText:(NSString *)text inRange:(NSRange)range;

@end

@interface UIVVTextField : UITextField {
    long limit;
    UILabel *limitLabel;
}

@property (nonatomic, assign) id<UIVVTextFieldDelegate> delegate;

@property (readwrite, nonatomic) long limit;
@property (retain, nonatomic) UILabel *limitLabel;

@end
