//
//  ViewController.m
//  MasonryDemo
//
//  Created by Karen on 15/12/6.
//  Copyright © 2015年 佑佑. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <MMPlaceHolder.h>
#import "SecondViewController.h"
#import "TwoViewController.h"
@interface ViewController ()
@property (nonatomic, strong)MASConstraint * widthConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  view
     */
    [self createViewTest];
  
    
}

-(void)createViewTest {
    UIButton *Next = [UIButton buttonWithType:UIButtonTypeCustom];
    Next.backgroundColor = [UIColor blackColor];
    [Next setTitle:@"ScrollView" forState:UIControlStateNormal];
    [Next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Next setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:Next];
    [Next addTarget:self action:@selector(handleNext:) forControlEvents:UIControlEventTouchUpInside];
    [Next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
    }];
    UIButton *Next2 = [UIButton buttonWithType:UIButtonTypeCustom];
    Next2.backgroundColor = [UIColor blackColor];
    [Next2 setTitle:@"TextField" forState:UIControlStateNormal];
    [Next2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Next2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:Next2];
    [Next2 addTarget:self action:@selector(handleTwo:) forControlEvents:UIControlEventTouchUpInside];
    [Next2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
    }];
    
    // 防止block循环引用
//    __weak typeof (self)weakSelf = self;
    
    UIView *green = [UIView new];
    green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:green];
    [green showPlaceHolder];
    
    
    UIView *yellow = [UIView new];
    yellow.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellow];
    [yellow showPlaceHolder];
    
    
    /**
     *  设置约束
     *  使用mas_MakeConstraints:添加约束
     */
#if 0
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        // 1.make就是添加约束的控件
        // make.left.equalTo 的意思是左侧和谁相同 .offset则是偏移量 上左下右
        make.top.equalTo(self.view.mas_top).offset(30);// 和父视图顶部间距30
        make.left.equalTo(self.view.mas_left).offset(30);// 和父视图左边间距30
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);// 和父视图底部间距30
        make.right.equalTo(self.view.mas_right).offset(-30);// 和父视图右边间距30
        
        // 2. edges边缘的意思 2等价于1
        make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(30, 30, 30, 30));
        
        // 3. 还等价于
        make.top.left.bottom.and.right.equalTo(self.view).width.insets(UIEdgeInsetsMake(30, 30, 30, 30));
        
        // 4.此处给yellow一个size 且让其居中
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.equalTo(self.view);
        
        
    }];
#endif
    /**
     *  mas_makeConstraints  只负责添加约束 AutoLayout不能同时存在两条针对同一对象的约束否则会报错
     *  mas_updateConstraints  针对上面的情况 会更新在block中出现的约束 不会导致出现两个相同约束的情况
     *  mas_remakeConstraints  清除之前所有的约束只保留新的约束
     *
     *  三种函数要配合使用
     */
#if 0
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.size.mas_equalTo(CGSizeMake(300, 300));
        
        make.size.mas_equalTo(self.view).offset(-20);// 同下
        //  make.size.equalTo(self.view).offset(-20);
        
        //        make.centerX.equalTo(self.view.mas_centerX);
        //        make.centerY.equalTo(self.view.mas_centerY); // 同下
        make.center.equalTo(self.view);
    }];
#endif
#if 0
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 120));// green大小
        make.top.mas_equalTo(green.superview).offset(100);// green顶部到它父视图的偏移量
        
        make.bottom.mas_equalTo(yellow.mas_top).offset(-50);// 50如果为正就是green底部到yellow顶部距离为50 为负就是green下边到yellow上边为50
        make.centerX.equalTo(green.superview.mas_centerX);// 中心点的X坐标和父视图中心点的X相同 说人话就是在中间
    }];
    
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        //   make.size.equalTo(green); // 等同于下面两句
        make.width.equalTo(green.mas_width);
        make.height.equalTo(green.mas_height);
        
        
        //  make.size.mas_equalTo(CGSizeMake(250, 30)); // 给个size
        make.centerX.equalTo(green.mas_centerX);// centerX和green一样
        
        
    }];
#endif
#if 1

    // 创建一个空view 代表上一个view
    __block UIView *lastView = nil;
    // 间距为10
    int intes = 10;
    // 每行3个
    int num = 3;
    // 循环创建view
    for (int i = 0; i < 9; i++) {

        UIView *view = [UIView new];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor colorWithHue:(arc4random() % 256 / 256.0 ) saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5 alpha:0.2];

        // 添加约束
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            // 给个高度约束
            make.height.mas_equalTo(80);

            // 1. 判断是否存在上一个view
            if (lastView) {
                // 存在的话宽度与上一个宽度相同
                make.width.equalTo(lastView);
            } else {
                // 否则计算宽度  ！！！此处的判断条件是为了避免 最后一列约束冲突
                /**
                 *  这里可能大家会问 为什么上面我说最后一列会有冲突？
                 *  如果不添加判断的话会造成：
                 *  1添加了宽度约束 2所有列加了左侧约束 第3步给 最后一列添加了右侧约束
                 *  这里最后一列既有左侧约束又有右侧约束还有宽度约束 会造成约束冲突
                 *  所以这里添加宽度时将最后一列剔除
                 */
                if (i % num != 0) {
                    make.width.mas_equalTo((view.superview.frame.size.width - (num + 1)* intes)/4);
                }
            }
            // 2. 判断是否是第一列
            if (i % num == 0) {
                // 一：是第一列时 添加左侧与父视图左侧约束
                make.left.mas_equalTo(view.superview).offset(intes);
            } else {
                // 二： 不是第一列时 添加左侧与上个view左侧约束
                make.left.mas_equalTo(lastView.mas_right).offset(intes);
            }
            // 3. 判断是否是最后一列 给最后一列添加与父视图右边约束
            if (i % num == (num - 1)) {
                make.right.mas_equalTo(view.superview).offset(-intes);
            }
            // 4. 判断是否为第一列
            if (i / num == 0) {
                // 第一列添加顶部约束
                make.top.mas_equalTo(view.superview).offset(intes*10);
            } else {
                // 其余添加顶部约束 intes*10 是我留出的距顶部高度
                make.top.mas_equalTo(intes * 10 + ( i / num )* (80 + intes));
            }

        }];
        // 每次循环结束 此次的View为下次约束的基准
        lastView = view;
        
    }
#endif
#if 0
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        // 添加大小约束
        make.size.mas_equalTo(CGSizeMake(100, 100));
        // 添加左上边距约束
        make.left.and.top.mas_equalTo(20);
    }];
    
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        // 大小和上边距约束与green相同
        make.size.and.top.equalTo(green);
        // 添加右边距约束 上左为正下右为负
        make.right.mas_equalTo(-20);
    }];
    
    
#endif
    
#if 0
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        // 左上约束20 右侧约束-20
        make.left.and.top.mas_equalTo(20);
        // 右边约束为-20
        make.right.mas_equalTo(-20);
    }];
    
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        // 下右约束-20
        make.bottom.and.right.mas_equalTo(-20);
        // 高度和green相同
        make.height.equalTo(green);
        // 顶部到green底部距离为20
        make.top.equalTo(green.mas_bottom).offset(20);
        // 左侧到视图中心的距离为20
        make.left.equalTo(weakSelf.view.mas_centerX).offset(20);
    }];
#endif
#if 0
    UIView *gray = [UIView new];
    gray.backgroundColor = [UIColor grayColor];
    [self.view addSubview:gray];
    [gray showPlaceHolder];
    
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        // 左上下距离父视图都为0
        make.left.and.top.and.bottom.mas_equalTo(0);
        // 宽度为200
        make.width.mas_equalTo(200);
    }];
    UIView *w = [UIView new];
    w.backgroundColor = [UIColor colorWithWhite:0.228 alpha:1.000];
    [w showPlaceHolder];
    [self.view addSubview:w];
    
    UIView *light = [UIView new];
    light.backgroundColor = [UIColor lightGrayColor];
    [light showPlaceHolder];
    [self.view  addSubview:light];
    
    [w mas_makeConstraints:^(MASConstraintMaker *make) {
        // w底部距离父视图centerY的距离为10
        make.bottom.equalTo(weakSelf.view.mas_centerY).mas_equalTo(-10);
        // 左侧距离gray距离为20
        make.left.equalTo(gray).offset(20);
        // 右侧距离gray距离20
        make.right.equalTo(gray).offset(-20);
        make.height.mas_equalTo(100);
    }];
    [light mas_makeConstraints:^(MASConstraintMaker *make) {
        // 顶部距离父视图centerY为10
        make.top.equalTo(weakSelf.view.mas_centerY).mas_equalTo(10);
        // 左右和高度与w相同
        make.left.and.right.and.height.equalTo(w);
        
    }];
    
#endif
#if 0
    UIView *w = [UIView new];
    w.backgroundColor = [UIColor colorWithWhite:0.228 alpha:1.000];
    [w showPlaceHolder];
    [self.view addSubview:w];
    
    UIView *light = [UIView new];
    light.backgroundColor = [UIColor lightGrayColor];
    [light showPlaceHolder];
    [self.view  addSubview:light];
    

    [w mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(green.mas_top).offset(-20);
        make.width.mas_equalTo(w.mas_height);
        make.centerX.equalTo(weakSelf.view.mas_centerX).offset(-20);
    }];
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(w.mas_bottom).offset(20);
        make.bottom.mas_equalTo(light.mas_top).offset(-20);
        make.height.equalTo(w);
        make.width.equalTo(weakSelf.view.mas_width).offset(-40);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        
    }];
    [light mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(green.mas_bottom).offset(20);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-20);
        make.size.mas_equalTo(w);
        make.centerX.equalTo(weakSelf.view.mas_centerX).offset(20);
        
    }];
    
#endif
    
#if 0
    UIView *light = [UIView new];
    light.backgroundColor = [UIColor lightGrayColor];
    [light showPlaceHolder];
    [self.view  addSubview:light];
    
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
        make.top.mas_equalTo(100);
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(yellow.mas_left).offset(-10);
        make.height.mas_equalTo(150);
        make.width.equalTo(yellow);
    }];
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(green.mas_centerY);
        make.left.equalTo(green.mas_right).offset(10);
        make.right.equalTo(light.mas_left).offset(-10);
        make.height.mas_equalTo(150);
        make.width.equalTo(light);
    }];
    [light mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(yellow.mas_centerY);
        make.left.equalTo(yellow.mas_right).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.mas_equalTo(150);
        make.width.equalTo(green);
        
    }];
    
    
#endif
#if 0
    
    UIView *light = [UIView new];
    light.backgroundColor = [UIColor lightGrayColor];
    [light showPlaceHolder];
    [self.view  addSubview:light];
    
    UIView *w = [UIView new];
    w.backgroundColor = [UIColor colorWithWhite:0.228 alpha:1.000];
    [w showPlaceHolder];
    [light addSubview:w];
    
    
    UIView *or = [UIView new];
    or.backgroundColor = [UIColor orangeColor];
    [or showPlaceHolder];
    [yellow addSubview:or];
    
    UIView *cy = [UIView new];
    cy.backgroundColor = [UIColor cyanColor];
    [cy showPlaceHolder];
    [yellow  addSubview:cy];
    
    UIView *bl = [UIView new];
    bl.backgroundColor = [UIColor blueColor];
    [bl showPlaceHolder];
    [yellow  addSubview:bl];
    
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(30, 10, 300, 10));
        make.top.left.equalTo(@20);
        make.right.mas_equalTo(-10);
        
    }];
    
    [w mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(weakSelf.view).offset(-20);
        make.height.mas_equalTo(yellow);
        make.top.mas_equalTo(yellow.mas_bottom).offset(20);
        make.width.mas_equalTo(green);
        make.right.mas_equalTo(green.mas_left).offset(-20);

    }];
    
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yellow.mas_bottom).offset(20);
        make.left.equalTo(w.mas_right).offset(20);
        make.right.equalTo(yellow.mas_right);
        make.height.mas_equalTo(or.mas_height);
    }];
    
    [or mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(yellow.mas_top).offset(20);
        make.left.mas_equalTo(light.mas_left).offset(30);
        make.width.mas_equalTo(bl.mas_width);
        
    }];
    
    [cy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(or.mas_bottom).offset(30);
        make.left.mas_equalTo(or.mas_left);
        make.height.mas_equalTo(or.mas_height);
        make.width.mas_equalTo(or.mas_width);
        make.bottom.mas_equalTo(yellow).offset(-20);
        
    }];
    
    [bl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(or.mas_top);
        make.left.mas_equalTo(or.mas_right).offset(20);
        make.bottom.mas_equalTo(cy.mas_bottom);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-20);
        
    }];
    
#endif
    
#if 0
    
    
    
#endif
    
#if 0
    /**
     *  更新约束
     */
    [yellow mas_updateConstraints:^(MASConstraintMaker *make) {
        
        
        
        
    }];
    
    /**
     *  将之前的约束全部删除添加新约束
     */
    [yellow mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
#endif
    

}

-(void)handleNext:(UIButton *)next {
    SecondViewController *second = [[SecondViewController alloc] init];
    [self presentViewController:second animated:YES completion:^{
        
    }];
}

-(void)handleTwo:(UIButton *)button {
    
    TwoViewController *two = [[TwoViewController alloc] init];
    [self presentViewController:two animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
