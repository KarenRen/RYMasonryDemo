//
//  TwoViewController.m
//  MasonryDemo
//
//  Created by 赵德玉 on 15/12/7.
//  Copyright © 2015年 金金. All rights reserved.
//

#import "TwoViewController.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"
@interface TwoViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof (self)weakSelf = self;
    self.textField = [UITextField new];
    self.textField.placeholder = @"请输入";
    self.textField.delegate = self;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    self.textField.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.bottom.mas_equalTo(-40);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.backgroundColor = [UIColor blackColor];
    [back setTitle:@"BACK" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(25);
    }];

    
}

-(void)handleBack:(UIButton *)back {

    [self dismissViewControllerAnimated:YES completion:^{

    }];

}

-(void)keyBoardWillShow:(NSNotification*)noti {
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [noti userInfo];
    CGRect rect =
    [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration =
    [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改下边距约束
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
    
    // 更新约束
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardWillDisappear:(NSNotification *)noti {
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [noti userInfo];
    CGRect rect =
    [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
//    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration =[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40);
    }];
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
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
