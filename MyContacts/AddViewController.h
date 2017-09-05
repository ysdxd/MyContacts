

#import <UIKit/UIKit.h>

@class AddViewController,Contatc;

@protocol AddViewControllerDelegate <NSObject>

- (void)addViewControllerDidAddBtn:(AddViewController *)addViewController contatc:(Contatc *)contatc;

@end

@interface AddViewController : UIViewController


@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;

@end
