//
//  ViewController.m
//  CollectionReorderTest
//
//  Created by Hamming, Tom on 5/2/18.
//  Copyright © 2018 Olive Tree Bible Software. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"
#import "CollectionViewCell.h"

@interface ViewController ()
@property UICollectionView *collectionView;
@property NSMutableArray<NSString *> *data;
@property UILongPressGestureRecognizer *dragReorderRecognizer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [NSMutableArray array];
    for (int i = 0; i < 30; i++)
    {
        [self.data addObject:[NSString stringWithFormat:@"%i", i]];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.dragReorderRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onLongPress:)];
    [self.collectionView addGestureRecognizer:self.dragReorderRecognizer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(60, 80);
//}

-(void)onLongPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [sender locationInView:self.collectionView];
        NSIndexPath *selectedPath = [self.collectionView indexPathForItemAtPoint:location];
        if (!selectedPath)
            return;
        
        [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedPath];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint location = [sender locationInView:self.collectionView];
        [self.collectionView updateInteractiveMovementTargetPosition:location];
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.collectionView endInteractiveMovement];
        [self.collectionView reloadData];
    }
    else
    {
        [self.collectionView cancelInteractiveMovement];
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.label.text = self.data[indexPath.item];
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *element = self.data[sourceIndexPath.item];
    [self.data removeObjectAtIndex:sourceIndexPath.item];
    [self.data insertObject:element atIndex:destinationIndexPath.item];
}

@end
