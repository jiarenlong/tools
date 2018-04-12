//
//  RLTabBar.m
//  ytsbCMS
//

//

#import "RLTabBar.h"
#import "CLog.h"
#import "MyViewController.h"
#import "InfoViewController.h"
#import "ServiceViewController.h"
#import "AppDelegate.h"

@interface RLTabBar ()

@end

@implementation RLTabBar


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createTabBarUI];
    }
    return self;
}

- (void)createTabBarUI {
    
    self.normalImageArray = @[@"home_normal",@"service_normal",@"info_normal",@"my_normal"];
    self.selectedImageArray = @[@"home_select",@"service_select",@"info_select",@"my_select"];
    self.titleArray = @[@"首页",@"服务",@"资讯",@"我的"];
    
    self.barTintColor = RGBACOLOR(20, 142, 227, 1);
    
    for (int i = 0; i < self.normalImageArray.count; i++) {
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / self.normalImageArray.count, 0, SCREEN_WIDTH / self.normalImageArray.count, 49)];

        itemView.tag = i + 1000;
        
        [self initLabelAndImageViewWithView:itemView index:i];
        
        [self addSubview:itemView];
        
    }
    
}

- (void)initLabelAndImageViewWithView:(UIView *)itemView index:(int)index {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 , 14, 20, 20)];
    
    CLog(@"imageview_x:%f labelX:%f labelWidth:%f",15 + index * SCREEN_WIDTH / self.normalImageArray.count,42 + index * SCREEN_WIDTH / self.normalImageArray.count,SCREEN_WIDTH / self.normalImageArray.count - 45);
    
    imageView.tag = 100 + index;
    
   [itemView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 10, SCREEN_WIDTH / self.normalImageArray.count - 45, 29)];
    titleLabel.tag = 200 + index;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = self.titleArray[index];
    [itemView addSubview:titleLabel];

    if (index == 0) {
        //设置选中首页字的颜色和图片
        titleLabel.textColor = [UIColor whiteColor];
        imageView.image = [UIImage imageNamed:self.selectedImageArray[index]];
    } else {
        //设置未选中字的颜色
        titleLabel.textColor = RGBACOLOR(161, 210, 244, 1);
        imageView.image = [UIImage imageNamed:self.normalImageArray[index]];
    }
}
//选中tabbar图片和文字高亮
- (void)selectedImageAndTitleColorWithTabBar:(RLTabBar *)tabBar index:(NSInteger)index  {
    
    for (int i = 0; i < self.normalImageArray.count; i++) {

       UILabel *titleLabel = [tabBar viewWithTag:i + 200];
       UIImageView *imageView = [tabBar viewWithTag:i + 100];
        int intIndex = (int)(index);
        if (i == intIndex) {
            titleLabel.textColor = [UIColor whiteColor];
            imageView.image = [UIImage imageNamed:self.selectedImageArray[i]];
        } else {
            titleLabel.textColor = RGBACOLOR(161, 210, 244, 1);
            imageView.image = [UIImage imageNamed:self.normalImageArray[i]];
        }
    }
    
}
//选中tabbar的点击事件。
- (void)itemViewClickWithTabBar:(RLTabBar *)tabBar index:(NSInteger)index {
    
    switch (index) {
        case 0:
            
            [self selectedImageAndTitleColorWithTabBar:tabBar index:index];
            
            break;
        
        case 1: {
        
            [self selectedImageAndTitleColorWithTabBar:tabBar index:index];
            
            break;
        }
    
        case 2: {
            
            [self selectedImageAndTitleColorWithTabBar:tabBar index:index];
        
            break;

        }
            
            
        case 3: {
           
            [self selectedImageAndTitleColorWithTabBar:tabBar index:index];
           
            break;
        }
            

            
        default:
            break;
    }
    
}


@end
