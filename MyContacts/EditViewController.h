

#import <UIKit/UIKit.h>
@class EditViewController,Contatc;

@protocol EditViewControllerDelegate <NSObject>

-(void)editViewControllerDidClickSavBtn:(EditViewController *)editViewController contatc:(Contatc *)cpmtatc;

@end

@interface EditViewController : UIViewController

/**
 *  用于接收联系人列表传递过来的数据
 */
@property (nonatomic, strong) Contatc *contatc;

@property (nonatomic, weak) id<EditViewControllerDelegate> delegate;

@end
