//
//  DiningCell.m
//  Penn Labs Dining
//
//  Created by Neil Shweky on 9/17/17.
//  Copyright © 2017 Neil Shweky. All rights reserved.
//

#import "DiningCell.h"
#import "DiningArea.h"
@implementation DiningCell

+(instancetype)cellForDiningArea:(DiningArea *)d{
    
    //Configuring the UI
    
    DiningCell *cell = [[DiningCell alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    cell.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f];
    
    cell.layer.shadowColor = [UIColor grayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 5);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 0.5f;
    
    cell.diningArea = d;
    //Split the Dining Cell into two halves, the image and the info.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width/2, cell.frame.size.height)];
    [imageView setImage: d.image];
    [cell addSubview: imageView];
    
    CGFloat infoViewX = imageView.frame.size.width;
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(infoViewX, 0, cell.frame.size.width - infoViewX, cell.frame.size.height)];
    infoView.userInteractionEnabled = NO;
    [cell addSubview:infoView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, infoView.frame.size.height/2-5, infoView.frame.size.width-30, 20)];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f];
    nameLabel.text = d.name;
    nameLabel.adjustsFontSizeToFitWidth = YES;
    [nameLabel sizeToFit];
    [infoView addSubview:nameLabel];
    
    cell.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, nameLabel.frame.origin.y + nameLabel.frame.size.height + 5, nameLabel.frame.size.width, 15)];
    cell.timeLabel.text = @"CLOSED";
    cell.timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8.0f];
    cell.timeLabel.textColor = [UIColor blackColor];
    [infoView addSubview:cell.timeLabel];
    
    cell.userInteractionEnabled = YES;
    
    return cell;
    
}

//Just a helper function to make life easier
-(void)setY: (CGFloat)y{

    [self setFrame:CGRectMake(0, y, self.frame.size.width, self.frame.size.height)];

}


@end
