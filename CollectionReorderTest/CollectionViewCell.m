//
//  CollectionViewCell.m
//  CollectionReorderTest
//
//  Created by Hamming, Tom on 5/2/18.
//  Copyright © 2018 Olive Tree Bible Software. All rights reserved.
//

#import "CollectionViewCell.h"
#import "PureLayout.h"

@implementation CollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.label = [UILabel newAutoLayoutView];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.label autoSetDimensionsToSize:CGSizeMake(40, 40)];
        [self.contentView addSubview:self.label];
        [self.label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
        
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return self;
}

@end
