//
//  SecondViewController.m
//  MasonryDemo
//
//  Created by 赵德玉 on 15/12/7.
//  Copyright © 2015年 金金. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    /**
     *  scrollView
     */
    [self createScrollView];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.backgroundColor = [UIColor blackColor];
    [back setTitle:@"BACK" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-5);
    }];
}
-(void)createScrollView {
    
    UIScrollView *scr = [UIScrollView new];
    scr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scr];
    [scr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(10, 10, 50, 10));
    }];
    
    UIView *container = [UIView new];
    [scr addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scr);
        make.width.equalTo(scr);
    }];
    
    int count = 20;
    UIView *lastView = nil;
    
    // 循环便利位置约束
    for (int i = 0; i <= count; i++) {
        UIView *subView = [UIView new];
        [container addSubview:subView];
        // 随机色
        subView.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )saturation:( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 200 / 256.0 ) + 0.5 alpha:1];
        
        // 为其添加约束
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            //
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(20 * i));
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        lastView = subView;
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
}

-(void)handleBack:(UIButton *)back {
   
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
