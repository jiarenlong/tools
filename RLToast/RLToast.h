//
//  RLToast.h
//  UserProject
//

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 2.0f
typedef NS_ENUM(NSUInteger, JKALERT_ITEM_TYPE) {
    JKALERT_ITEM_TYPE_OK,
    JKALERT_ITEM_TYPE_CANCEL,
    JKALERT_ITEM_TYPE_OTHER
};
typedef NS_ENUM(NSUInteger, JKALERT_STYLE) {
    JKALERT_STYLE_ALERT,
    JKALERT_STYLE_ACTION_SHEET
};
@class JKAlertItem;
typedef void (^JKAlertHandler)(JKAlertItem *item);

@interface RLToast : NSObject {
    NSString *_text;
    UIButton *_contentView;
    CGFloat  _duration;
}

+ (void)toastWithText:(NSString *)text;
+ (void)toastWithText:(NSString *)text
             duration:(CGFloat)duration;

+ (void)toastWithText:(NSString *)text
            topOffset:(CGFloat)topOffset;
+ (void)toastWithText:(NSString *)text
            topOffset:(CGFloat)topOffset
             duration:(CGFloat)duration;

+ (void)toastWithText:(NSString *)text
         bottomOffset:(CGFloat)bottomOffset;
+ (void)toastWithText:(NSString *)text
         bottomOffset:(CGFloat)bottomOffset
             duration:(CGFloat)duration;

@property (nonatomic, copy) NSString *title;
@property (nonatomic) JKALERT_ITEM_TYPE type;
@property (nonatomic) NSUInteger tag;
@property (nonatomic, copy) JKAlertHandler action;

@end
