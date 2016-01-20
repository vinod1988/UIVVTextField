//
//  UIVVTextView.m
//  UIVVTextField
//
//  Created by Vinod Vishwakarma on 26/10/15.
//  Copyright © 2015 Vinod Vishwakarma. All rights reserved.
//

#import "UIVVTextView.h"

@implementation UIVVTextView


@synthesize limit,limitLabel,delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        limit=10;// -- Default limit
        [super setDelegate:(id<UIVVTextViewDelegate,UITextViewDelegate>)self];
        [self initializeLimitLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)inCoder {
    self = [super initWithCoder:inCoder];
    if (self) {
        limit=10;// -- Default limit
        [super setDelegate:(id<UIVVTextViewDelegate,UITextViewDelegate>)self];
        [self initializeLimitLabel];
    }
    return self;
}

-(long)limit {
    return limit;
}

-(void)initializeLimitLabel {
    [self initializeLimitLabelWithFont:[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:14.0] andTextColor:[UIColor redColor]];// <-- Customize the label font and color. BUT! By customizing the size and, you will have to change the bounds
}

-(void)setLimit:(long)theLimit {
    limit=theLimit;
    [self textView:self shouldChangeTextInRange:NSMakeRange(0, 0) replacementText:@""];
}

-(void)initializeLimitLabelWithFont:(UIFont *)font andTextColor:(UIColor *)textColor {
    limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-([[NSNumber numberWithFloat:font.pointSize] doubleValue]*(2.285714)), 8, 30, self.bounds.size.height)];
    
    [limitLabel setTextColor:textColor];
    [limitLabel setFont:font];
    
    [limitLabel setBackgroundColor:[UIColor clearColor]];
    [limitLabel setTextAlignment:NSTextAlignmentLeft];
    [limitLabel setNumberOfLines:1];
    [limitLabel setText:@""];
    [self.superview addSubview:limitLabel];
    [self textView:self shouldChangeTextInRange:NSMakeRange(0, 0) replacementText:@""];
    
    limitLabel.hidden=YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    long MAXLENGTH=limit;
    
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if(newText.length == MAXLENGTH) {//Did reach limit
        if([self.delegate respondsToSelector:@selector(textViewLimit:didReachLimitWithLastEnteredText:inRange:)]) {
            [self.delegate textViewLimit:self didReachLimitWithLastEnteredText:text inRange:NSMakeRange(range.location, text.length)];
        }
    }
    if(newText.length>MAXLENGTH) {
        [self shakeLabel];
        if([self.delegate respondsToSelector:@selector(textViewLimit:didWentOverLimitWithDisallowedText:inDisallowedRange:)]) {
            [self.delegate textViewLimit:self didWentOverLimitWithDisallowedText:text inDisallowedRange:NSMakeRange(range.location, text.length)];
        }
        if([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            return [self.delegate textView:self shouldChangeTextInRange:range replacementText:text];
        }
        return NO;
    }
    [limitLabel setText:[NSString stringWithFormat:@"%lu",MAXLENGTH-newText.length]];
    
    if([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([self.delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.delegate textViewDidBeginEditing:self];
    }
    
    limitLabel.hidden=YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {

    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:self];
    }
    
    if(limitLabel.isHidden) {
        limitLabel.hidden=NO;
    }
}



-(void)shakeLabel {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(limitLabel.center.x - 5,limitLabel.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(limitLabel.center.x + 5, limitLabel.center.y)]];
    [limitLabel.layer addAnimation:shake forKey:@"position"];
}



//UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.delegate textViewShouldBeginEditing:self];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.delegate textViewShouldEndEditing:self];
    }
    return YES;
}



@end