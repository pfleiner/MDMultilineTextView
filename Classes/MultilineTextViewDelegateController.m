//
//  MultilineTextViewContainerViewController.m
//  Multiline-TextView
//
//  Created by Mounir Dellagi on 14.10.13.
//  Copyright (c) 2013 Mounir Dellagi. All rights reserved.
//

#import "MultilineTextViewDelegateController.h"

@interface MultilineTextViewDelegateController ()

@property (nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@end

@implementation MultilineTextViewDelegateController {
}

#pragma mark - Keyboard Handling
/** Handling the text view position relative to the keyboard */
- (void)keyboardHandling
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        NSDictionary *info = [note userInfo];
        CGSize kbSize = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        self.bottomLayoutConstraint.constant += kbSize.height;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.view layoutIfNeeded];
            
        } completion:nil];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        NSDictionary *info = [note userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        self.bottomLayoutConstraint.constant -= kbSize.height;
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];}
         ];
        
    }];
}

#pragma mark - Text View Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    // Tell layout system that size changed
    if (self.multiTextView.contentSize.height < self.multiTextView.maxHeight) {
        [self.multiTextView invalidateIntrinsicContentSize];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self keyboardHandling];
}

@end
