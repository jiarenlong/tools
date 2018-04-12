
//
//  RLAlert.m
//  DidaHireCar
//

//

#import "RLAlert.h"
#import <objc/runtime.h>

static const void *AlertObject = &AlertObject;
@implementation RLAlertItem

@end

@interface RLAlert()<UIActionSheetDelegate, UIAlertViewDelegate> {
    NSMutableArray *_items;
    NSString *_title;
    NSString *_message;
    RLALERT_STYLE _styleType;
    
}

@property (nonatomic ,strong)UIViewController *topShowViewController;

@end

@implementation RLAlert

#pragma mark -- init 
- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message style:(RLALERT_STYLE)style {
    self = [super init];
    if (self != nil) {
        _items = [NSMutableArray array];
        _title = title;
        _message = message;
        _styleType = style;
    }
    return self;
}

+ (id)alertWithTitle:(NSString *)title andMessage:(NSString *)message {
    return [[self alloc] initWithTitle:title andMessage:message style:RLALERT_STYLE_ALERT];
}

+ (id)actionSheetWithTitle:(NSString *)title andMessage:(NSString *)message {
    return [[self alloc] initWithTitle:title andMessage:message style:RLALERT_STYLE_ACTION_SHEET];
}

#pragma mark -- add button and handle
- (NSInteger)addButtonWithTitle:(NSString *)title {
    NSAssert(title != nil, @"all title must be non-nil");
    
    RLAlertItem *item = [[RLAlertItem alloc] init];
    item.title = title;
    item.action = ^(RLAlertItem *item) {
        NSLog(@"no action");
    };
    item.type = RLALERT_ITEM_TYPE_OTHER;
    [_items addObject:item];
    return  [_items indexOfObject:title];
}

- (void)addButton:(RLALERT_ITEM_TYPE)type withTitle:(NSString *)title handler:(RLAlertHandler)handler {
    NSAssert(title != nil, @"all title must be non-nil");
    
    RLAlertItem *item = [[RLAlertItem alloc] init];
    item.title = title;
    item.action = handler;
    item.type = type;
    [_items addObject:item];
    item.tag = [_items indexOfObject:item];
}

- (void)addCancelButtonWithTitle:(NSString *)title handler:(RLAlertHandler)handler {
    
    [self addButton:RLALERT_ITEM_TYPE_CANCEL withTitle:title handler:handler];
}

- (void)addCommonButtonWithTitle:(NSString *)title handler:(RLAlertHandler)handler {
    [self addButton:RLALERT_ITEM_TYPE_OTHER withTitle:title handler:handler];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex {
    RLAlertItem *item = _items[buttonIndex];
    return item.title;
}

- (NSArray *)actions {
    return [_items copy];
}

#pragma mark -- show
- (void)show {
    if (NSClassFromString(@"UIAlertController") != nil) {
        [self show8];
    } else {
        [self show7];
    }
}

- (void)show8 {
    UIAlertControllerStyle controllerStyle;
    if (_styleType == RLALERT_STYLE_ALERT) {
        controllerStyle = UIAlertControllerStyleAlert;
    } else {
        controllerStyle = UIAlertControllerStyleActionSheet;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:controllerStyle];
    for (RLAlertItem *item in _items) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        
        if (item.type == RLALERT_ITEM_TYPE_CANCEL) {
            style = UIAlertActionStyleCancel;
        }
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:item.title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (item.action) {
                item.action(item);
            }
        }];
        
        [alertController addAction:alertAction];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.topShowViewController presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)show7 {
    if (_styleType == RLALERT_STYLE_ALERT) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        objc_setAssociatedObject(alertView, &AlertObject, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        for (RLAlertItem *item in _items) {
            if (item.type == RLALERT_ITEM_TYPE_CANCEL) {
                [alertView setCancelButtonIndex:[alertView addButtonWithTitle:item.title]];
            } else {
                [alertView addButtonWithTitle:item.title];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:_title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        objc_setAssociatedObject(actionSheet, &AlertObject, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        for (RLAlertItem *item in _items) {
            if (item.type == RLALERT_ITEM_TYPE_CANCEL) {
                [actionSheet setCancelButtonIndex:[actionSheet addButtonWithTitle:item.title]];
            } else {
                [actionSheet addButtonWithTitle:item.title];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [actionSheet showInView:self.topShowViewController.view];
        });
    }
}

#pragma mark -- topVC 
- (UIViewController *)topShowViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

#pragma  mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    RLAlertItem *item = _items[buttonIndex];
    if (item.action) {
        item.action(item);
    }
}

#pragma mark -- actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    RLAlertItem *item = _items[buttonIndex];
    if (item.action) {
        item.action(item);
    }
}

+ (id)showMessage:(NSString *)title message:(NSString *)message {
    if (message == nil) {
        return nil;
    }
    RLAlert *alert = [[RLAlert alloc] initWithTitle:title andMessage:message style:RLALERT_STYLE_ALERT];
    [alert addButtonWithTitle:@"确定"];
    [alert show];
    return alert;
}

+ (id)showMessage:(NSString *)message {
    return [[self class] showMessage:@"提示" message:message];
}


@end

@implementation UIAlertController (Rotation)

#pragma mark self rotate    
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL) shouldAutorotate {
    return YES;
}

@end
