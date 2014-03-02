//
//  MultilineTextViewContainerViewController.m
//  Multiline-TextView
//
//  Created by Mounir Dellagi on 14.10.13.
//  Copyright (c) 2013 Mounir Dellagi. All rights reserved.
//

#import "MDMultilineTextViewDelegateController.h"

@interface MDMultilineTextViewDelegateController ()

@property (nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@end

@implementation MDMultilineTextViewDelegateController {
}

#pragma mark - Keyboard Handling
/** Handling the text view position relative to the keyboard */
- (void)keyboardHandling
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        NSDictionary *info = [note userInfo];
        CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        self.bottomLayoutConstraint.constant += kbSize.height;
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.view layoutIfNeeded];} completion:nil
         ];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        NSDictionary *info = [note userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        self.bottomLayoutConstraint.constant -= kbSize.height;
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.view layoutIfNeeded];} completion:nil
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
    
    [self.multiTextView scrollRectToVisible:CGRectMake(0.0, self.multiTextView.contentSize.height - 1.0f, 1.0, 1.0) animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self keyboardHandling];
}

@end
