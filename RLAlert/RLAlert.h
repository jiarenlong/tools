//
//  RLAlert.h
//  DidaHireCar
//

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RLALERT_ITEM_TYPE) {
    RLALERT_ITEM_TYPE_OK,
    RLALERT_ITEM_TYPE_CANCEL,
    RLALERT_ITEM_TYPE_OTHER
};

typedef NS_ENUM(NSUInteger, RLALERT_STYLE) {
    RLALERT_STYLE_ALERT,         //alert
    RLALERT_STYLE_ACTION_SHEET   //sheet
};
@class RLAlertItem;
typedef void(^RLAlertHandler)(RLAlertItem *item);

@interface UIAlertController (Rotation)

@end

@interface RLAlert : NSObject

- (instancetype)init __attribute__((unavailable("Forbidden use init!")));

@property (nonatomic, readonly) NSArray *actions;

/**
 *  @brief  类初始化方法
 *
 *  @param title   alert tiltle
 *  @param message alert message
 *
 *  @return JYAlert with JYALERT_STYLE_ALERT
 */
+ (id)alertWithTitle:(NSString *)title andMessage:(NSString *)message;
/**
 *  @brief  类初始化方法
 *
 *  @param title   actionSheet tiltle
 *  @param message actionSheet message
 *
 *  @return JYAlert with JYALERT_STYLE_ACTION_SHEET
 */
+ (id)actionSheetWithTitle:(NSString *)title andMessage:(NSString *)message;
/**
 *  @brief  通过title加一个没有block的按钮
 *
 *  @param title button title
 *
 *  @return button index
 */
- (NSInteger)addButtonWithTitle:(NSString *)title;
/**
 *  @brief  添加取消按钮，可以在block中写点击取消后的逻辑
 *
 *  @param title   button title
 *  @param handler handler block
 */
- (void)addCancelButtonWithTitle:(NSString *)title handler: (RLAlertHandler)handler;
/**
 *  @brief  添加common按钮，可以在block中写点击按钮后的逻辑
 *
 *  @param title   button title
 *  @param handler handler block
 */
- (void)addCommonButtonWithTitle:(NSString *)title handler:(RLAlertHandler)handler;
/**
 *  @brief  通过buttonindex找到title
 *
 *  @param buttonIndex buttonIndex
 *
 *  @return button title
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;
/**
 *  @brief  通过 JYALERT_STYLE_ALERT，显示提醒
 *
 *  @param title   alert tiltle
 *  @param message alert message
 */
+ (id)showMessage:(NSString *)title message:(NSString *)message;
/**
 *  @brief  通过 JYALERT_STYLE_ALERT，显示提醒
 *
 *  @param message alert message
 */
+ (id)showMessage:(NSString *)message;
/**
 *  @brief  显示方法
 */
- (void)show;

@end

@interface RLAlertItem : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic) RLALERT_ITEM_TYPE type;
@property (nonatomic) NSUInteger tag;
@property (nonatomic, copy) RLAlertHandler action;

@end
