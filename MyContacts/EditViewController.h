

#import <UIKit/UIKit.h>
@class JHEditViewController,NJContatc;

@protocol JHEditViewControllerDelegate <NSObject>

-(void)editViewControllerDidClickSavBtn:(JHEditViewController *)editViewController contatc:(NJContatc *)cpmtatc;

@end

@interface JHEditViewController : UIViewController

/**
 *  用于接收联系人列表传递过来的数据
 */
@property (nonatomic, strong) NJContatc *contatc;

@property (nonatomic, weak) id<JHEditViewControllerDelegate> delegate;

@end
