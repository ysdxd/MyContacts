

#import "TableViewCell.h"
#import "NJContatc.h"

@interface JHContatcCell ()
@property (nonatomic, weak) UIView *divider;

@end

@implementation JHContatcCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"contatcs";
    
    // 首先回去缓存池中找, 如果找不到回去storyboard中找有没有叫做contatcs的cell,有就创建
    JHContatcCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

-(void)setContatc:(NJContatc *)contatc
{
    _contatc = contatc;
    
    // 设置名称
    self.textLabel.text = _contatc.name;
    // 设置电话机
    self.detailTextLabel.text = _contatc.phoneNumber;
}

// 该方法只有在通过代码创建控件的时候才会调用, 如果控件是通过xib或者storyboard创建出来的不会调用该方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"initWithStyle");
    }
    return self;
}

// 如果控件是通过xib或者storyboard创建出来的就会调用该方法
// 该方法只会调用一次
- (void)awakeFromNib {
    // 创建分割线添加的cell中
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    self.divider = view;
    // 注意不要直接将子控件添加到cell中
    //    [self addSubview:view];
    
    [self.contentView addSubview:view];
}

// 当控件的frame被修改的时候就会调用
// 一般在该方法中布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置分割线的frame
    
    CGFloat x = 0;
    CGFloat h = 1;
    CGFloat w = self.frame.size.width;
    CGFloat y = self.frame.size.height - h;
    self.divider.frame = CGRectMake(x, y, w, h);
}

@end
