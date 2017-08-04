//
//  ViewController.m
//  Animation-GroupDemo
//
//  Created by 刘超 on 2017/8/3.
//  Copyright © 2017年 ogemray. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Draw.h"
#import "LCItemView.h"

@interface ViewController ()<LCItemViewDelegate>

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, strong) LCItemView *itemView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.itemView];
//    self.itemView.backgroundColor = [UIColor greenColor];
}

- (void)clickSubItemWithIndex:(NSUInteger)index
{
    NSLog(@"%lu",(unsigned long)index);
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [self.colors objectAtIndex:index];
    }];
}

- (LCItemView *)itemView
{
    if (!_itemView) {
        
        UIImage *mainItemImage = [UIImage imageWithShape:LCImageShapeMainItem andSize:CGSizeMake(55, 55) andStrokeColor:[UIColor redColor]];
        NSMutableArray *subItemImgs = [NSMutableArray array];
        for (int i = 0; i < self.colors.count; i++) {
            UIImage *subItemImage = [UIImage imageWithShape:LCImageShapeSubItem andSize:CGSizeMake(40, 40) andStrokeColor:[self.colors objectAtIndex:i]];
            [subItemImgs addObject:subItemImage];
        }
        _itemView = [[LCItemView alloc] initWithFrame:self.view.bounds andMainImage:mainItemImage andSubItems:subItemImgs];
        _itemView.delegate = self;
    }
    return _itemView;
}

- (NSArray *)colors
{
    if (!_colors) {
        _colors = [NSArray arrayWithObjects:[UIColor redColor],
                                            [UIColor greenColor],
                                            [UIColor blueColor],
                                            [UIColor cyanColor],
                                            [UIColor yellowColor],
                                            [UIColor magentaColor],
                                            [UIColor orangeColor],
                                            [UIColor purpleColor],
                                            [UIColor brownColor],
                                            [UIColor darkGrayColor], nil];
    }
    return _colors;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
