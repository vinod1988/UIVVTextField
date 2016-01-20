//
//  UIVVTextView.h
//  UIVVTextField
//
//  Created by Vinod Vishwakarma on 26/10/15.
//  Copyright © 2015 Vinod Vishwakarma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIVVTextView;

@protocol UIVVTextViewDelegate<UITextViewDelegate>

@optional
- (void)textViewLimit:(UIVVTextView *)textViewLimit didWentOverLimitWithDisallowedText:(NSString *)text inDisallowedRange:(NSRange)range;
- (void)textViewLimit:(UIVVTextView *)textViewLimit didReachLimitWithLastEnteredText:(NSString *)text inRange:(NSRange)range;

@end

@interface UIVVTextView : UITextView {
    long limit;
    UILabel *limitLabel;
}

@property (nonatomic, assign) id<UIVVTextViewDelegate> delegate;

@property (readwrite, nonatomic) long limit;
@property (retain, nonatomic) UILabel *limitLabel;

@end
