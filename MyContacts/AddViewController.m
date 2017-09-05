
#import "AddViewController.h"
#import "Contatc.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

/**
 *  点击添加按钮
 */
- (IBAction)addBtnOnClick:(UIButton *)sender;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听文本输入框的改变
    
    // 1.拿到通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 2.注册监听
    // 注意点: 一定要写上通知的发布者
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    
    [self addLoginButtonLayer];
}

- (void)addLoginButtonLayer {
    self.addBtn.layer.cornerRadius = 8;
    self.addBtn.layer.borderColor = [UIColor blueColor].CGColor;
    self.addBtn.layer.borderWidth = 1;
}

- (void)textChange
{
    self.addBtn.enabled = (self.nameField.text.length > 0  &&
                           self.phoneField.text.length > 0);
}

-(void)viewDidAppear:(BOOL)animated
{
    // 主动召唤键盘
    [self.nameField becomeFirstResponder];
}

- (IBAction)addBtnOnClick:(UIButton *)sender {
    
    // 1.移除栈顶控制器,返回到上一页
    [self.navigationController popViewControllerAnimated:YES];
    
    //2.获取用户输入的姓名和电话
    NSString *name = self.nameField.text;
    NSString *phone = self.phoneField.text;
    
    NJContatc *c = [[NJContatc alloc]init];
    c.name = name;
    c.phoneNumber = phone;
    c.email = @"iplaycloud@gmail.com";
    
    // 2.传递数据给联系人列表
    if ([self.delegate respondsToSelector:@selector(addViewControllerDidAddBtn:contatc:)]) {
        [self.delegate addViewControllerDidAddBtn:self contatc:c];
    }
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
