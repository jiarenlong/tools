//
//  RLTabBar.h
//  ytsbCMS
//

//

#import <UIKit/UIKit.h>

@interface RLTabBar : UITabBar

@property (nonatomic, strong)NSArray *normalImageArray;
@property (nonatomic, strong)NSArray *selectedImageArray;
@property (nonatomic, strong)NSArray *titleArray;

- (void)itemViewClickWithTabBar:(RLTabBar *)tabBar  index:(NSInteger)index;

@end
