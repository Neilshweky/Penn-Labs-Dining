//
//  DiningArea.h
//  Penn Labs Dining
//
//  Created by Neil Shweky on 9/17/17.
//  Copyright © 2017 Neil Shweky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 * Object that represents a dining hall
 */
@interface DiningArea : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;

@end
