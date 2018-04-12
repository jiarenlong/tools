//
//  RLPromptBox.m
//  UserProject
//

//

#import "RLPromptBox.h"
#import <QuartzCore/QuartzCore.h>

#define kAlertWidth 245.0f
#define kAlertHeight 40.0f

@interface RLPromptBox()
@property (nonatomic, strong) UILabel *alertTitleLabel;

@end

@implementation RLPromptBox

+ (CGFloat)alertWidth {
    return kAlertWidth;
}

+ (CGFloat)alertHeight {
    return kAlertHeight;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#define kTitleYOffset 15.0f
#define kTitleHeight 30.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define NetViewBgColor [UIColor whiteColor]
#define NetViewTextColor [UIColor orangeColor]


- (id)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        //lable的样式在这里设置
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        self.alertTitleLabel.textColor = NetViewTextColor;
        [self.alertTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.alertTitleLabel];
        self.alertTitleLabel.text = title;
        [self setAlpha:0];
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)show {
    UIViewController *topVC = [self appRootViewController];
    self.backgroundColor = NetViewBgColor;
    self.alpha = 0.5;
    self.frame = CGRectMake(CGRectGetWidth(topVC.view.bounds)-SCREEN_WIDTH, 0, SCREEN_WIDTH, kAlertHeight);
    [topVC.view addSubview:self];
}

- (void)dismissAlert {
    [self removeFromSuperview];
}

- (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview {
    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        return;
    }
    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
    [super willMoveToSuperview:newSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
