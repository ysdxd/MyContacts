

#import <UIKit/UIKit.h>
@class Contatc;

@interface ContatcCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) Contatc *contatc;

@end
