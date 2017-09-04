

#import <UIKit/UIKit.h>

@class JHAddViewController,NJContatc;

@protocol JHAddViewControllerDelegate <NSObject>

- (void)addViewControllerDidAddBtn:(JHAddViewController *)addViewController contatc:(NJContatc *)contatc;

@end

@interface JHAddViewController : UIViewController


@property (nonatomic, weak) id<JHAddViewControllerDelegate> delegate;

@end
