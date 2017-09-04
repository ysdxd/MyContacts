

#import <UIKit/UIKit.h>
@class NJContatc;

@interface JHContatcCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NJContatc *contatc;

@end
