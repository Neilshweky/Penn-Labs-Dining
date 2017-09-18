//
//  DiningCell.h
//  Penn Labs Dining
//
//  Created by Neil Shweky on 9/17/17.
//  Copyright © 2017 Neil Shweky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DiningArea;
/**
 * An Object of subclass UIButton that represents the cell of the corresponding dining hall object.
 *
 */
@interface DiningCell : UIButton

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) DiningArea *diningArea;

+(instancetype)cellForDiningArea:(DiningArea *)d;

-(void)setY: (CGFloat)y;

@end
