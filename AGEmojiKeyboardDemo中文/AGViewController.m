//
//  AGViewController.h
//  AGEmojiKeyboardDemo中文
//
//  Created by CoderXu on 16/7/8.
//  Copyright © 2016年 CoderXu. All rights reserved.

//

#import "AGViewController.h"
#import "AGEmojiKeyboardView.h"

typedef enum _InputType
{
    InputType_Text     = 0,
    InputType_Emoji    = 1,
} InputType;

@interface AGViewController () <AGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSource>
{
    AGEmojiKeyboardView *_emojiKeyboardView;
}
@property (nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) InputType growingInputType;
@end

@implementation AGViewController
//退键盘
- (IBAction)resignBtnClick:(id)sender {
    [_textView resignFirstResponder];
}
//切换emoji
- (IBAction)switchBtnClick:(id)sender {
    if (_growingInputType == InputType_Text) {
        [_textView resignFirstResponder];
        _textView.inputView = _emojiKeyboardView;
        [_textView becomeFirstResponder];
        self.growingInputType = InputType_Emoji;
    } else if (_growingInputType == InputType_Emoji) {
        [_textView resignFirstResponder];
        _textView.inputView = nil;
        [_textView becomeFirstResponder];
        self.growingInputType = InputType_Text;
    }

}

- (void)viewDidLoad {
  [super viewDidLoad];
    _growingInputType = InputType_Emoji;
//创建键盘
  AGEmojiKeyboardView *emojiKeyboardView = [[AGEmojiKeyboardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216) dataSource:self];
  emojiKeyboardView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  emojiKeyboardView.delegate = self;
    _emojiKeyboardView = emojiKeyboardView;
    //更改输入法view
  self.textView.inputView = emojiKeyboardView;
}
#pragma mark 数据源和代理
//选中表情后
- (void)emojiKeyBoardView:(AGEmojiKeyboardView *)emojiKeyBoardView didUseEmoji:(NSString *)emoji {
  self.textView.text = [self.textView.text stringByAppendingString:emoji];
}
//点击删除按钮
- (void)emojiKeyBoardViewDidPressBackSpace:(AGEmojiKeyboardView *)emojiKeyBoardView {
    [self.textView deleteBackward];
}
//删除按钮的图片
- (UIImage *)backSpaceButtonImageForEmojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView {
    UIImage *img = [self randomImage];
    [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

//生成随机色
- (UIColor *)randomColor {
  return [UIColor colorWithRed:drand48()
                         green:drand48()
                          blue:drand48()
                         alpha:drand48()];
}
//生成长方形图片,颜色随机
- (UIImage *)randomImage {
  CGSize size = CGSizeMake(30, 10);
  UIGraphicsBeginImageContextWithOptions(size , NO, 0);

  CGContextRef context = UIGraphicsGetCurrentContext();
  UIColor *fillColor = [self randomColor];
  CGContextSetFillColorWithColor(context, [fillColor CGColor]);
  CGRect rect = CGRectMake(0, 0, size.width, size.height);
  CGContextFillRect(context, rect);

  fillColor = [self randomColor];
  CGContextSetFillColorWithColor(context, [fillColor CGColor]);
  CGFloat xxx = 3;
  rect = CGRectMake(xxx, xxx, size.width - 2 * xxx, size.height - 2 * xxx);
  CGContextFillRect(context, rect);

  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}
//当前选中系列的标题图片
- (UIImage *)emojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView imageForSelectedCategory:(AGEmojiKeyboardViewCategoryImage)category {
  UIImage *img = [self randomImage];
  [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  return img;
}
//未选中状态的标题图片
- (UIImage *)emojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView imageForNonSelectedCategory:(AGEmojiKeyboardViewCategoryImage)category {
  UIImage *img = [self randomImage];
  [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  return img;
}

@end
