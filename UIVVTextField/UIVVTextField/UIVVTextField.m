//
//  UIVVTextField.m
//  UIVVTextField
//
//  Created by Vinod Vishwakarma on 26/10/15.
//  Copyright © 2015 Vinod Vishwakarma. All rights reserved.
//

#import "UIVVTextField.h"

@implementation UIVVTextField

@synthesize limit,limitLabel,delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        limit=0;// -- Default limit
        [super setDelegate:(id<UIVVTextFieldDelegate,UITextFieldDelegate>)self];
        [self initializeLimitLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)inCoder {
    self = [super initWithCoder:inCoder];
    if (self) {
        limit=0;// -- Default limit
        [super setDelegate:(id<UIVVTextFieldDelegate,UITextFieldDelegate>)self];
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
    [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
}

-(void)initializeLimitLabelWithFont:(UIFont *)font andTextColor:(UIColor *)textColor {
    limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-([[NSNumber numberWithFloat:font.pointSize] doubleValue]*(2.285714)), 8, 30, self.bounds.size.height)];
    
    [limitLabel setTextColor:textColor];
    [limitLabel setFont:font];
    
    [limitLabel setBackgroundColor:[UIColor clearColor]];
    [limitLabel setTextAlignment:NSTextAlignmentLeft];
    [limitLabel setNumberOfLines:1];
    [limitLabel setText:@""];
    [self setRightView:limitLabel];
    [self setRightViewMode:UITextFieldViewModeWhileEditing];
    [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
    
    limitLabel.hidden=YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    long MAXLENGTH=limit;
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(newText.length==MAXLENGTH) {//Did reach limit
        if([self.delegate respondsToSelector:@selector(textFieldLimit:didReachLimitWithLastEnteredText:inRange:)]) {
            [self.delegate textFieldLimit:self didReachLimitWithLastEnteredText:string inRange:NSMakeRange(range.location, string.length)];
        }
    }
    if(newText.length>MAXLENGTH) {
        [self shakeLabel];
        if([self.delegate respondsToSelector:@selector(textFieldLimit:didWentOverLimitWithDisallowedText:inDisallowedRange:)]) {
            [self.delegate textFieldLimit:self didWentOverLimitWithDisallowedText:string inDisallowedRange:NSMakeRange(range.location, string.length)];
        }
        if([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            return [self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
        }
        return NO;
    }
    [limitLabel setText:[NSString stringWithFormat:@"%lu",MAXLENGTH-newText.length]];
    
    if([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:self];//UITextFieldDelegate
    }
    limitLabel.hidden=YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];//UITextFieldDelegate
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



//UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:self];
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:self];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:self];
    }
    return YES;
}

@end