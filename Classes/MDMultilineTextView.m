//
//  MultilineTextView.m
//  Multiline-TextView
//
//  Created by Mounir Dellagi on 14.10.13.
//  Copyright (c) 2013 Mounir Dellagi. All rights reserved.
//

#import "MDMultilineTextView.h"

@interface MDMultilineTextView ()
@property (nonatomic) UILabel *placeholderLabel;

@end

@implementation MDMultilineTextView

#pragma  Custom Gettter to update content size when set programmatically
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self invalidateIntrinsicContentSize];
}

#pragma mark - Init
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Default Values (can be set via properties)
        _maxHeight = 100.0;
        _placeholderColor = [UIColor grayColor];
        _placeholder = @"Message";
        
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0] CGColor];
    }
    
    return self;
}

#pragma mark - Auto Layout
/** Calculates the content size of the text view used by auto layout to adjust the constraints */
- (CGSize)intrinsicContentSize
{
    CGSize newContentSize;
    if ([self.text length] == 0) {
        NSDictionary *attributes = @{NSFontAttributeName: self.font};
        CGRect rect = [self.placeholder boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil];
        CGSize textSize = rect.size;
        newContentSize = CGSizeMake(textSize.width, textSize.height + 16.0);
        [self showPlaceholderInFrame:CGRectMake(0.0, 0.0, newContentSize.width, newContentSize.height)];
    }
    else {
        NSDictionary *attributes = @{NSFontAttributeName: self.font};
        CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGSize textSize = rect.size;
        newContentSize = CGSizeMake(textSize.width, textSize.height + 16.0);
        [self removePlaceholder];
    }
    return newContentSize;
}

#pragma mark - Placeholder

/** Adds the placeholder label as a subview */
- (void)showPlaceholderInFrame:(CGRect)placeholderFrame
{
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.0f, 8.0f, placeholderFrame.size.width, placeholderFrame.size.height - 16.0f)];
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textColor  = self.placeholderColor;
    self.placeholderLabel.font = self.font;
    
    if (![self.placeholderLabel isDescendantOfView:self]) {
        [self addSubview:self.placeholderLabel];
    }
}

/** Removes the placeholder label subview */
- (void)removePlaceholder
{
    [self.placeholderLabel removeFromSuperview];
}


@end
