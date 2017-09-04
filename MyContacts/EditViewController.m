

#import "EditViewController.h"
#import "NJContatc.h"

@interface JHEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

/**
 *  编辑按钮点击事件
 */
- (IBAction)editBtnOnClick:(UIBarButtonItem *)sender;
/**
 *  保存按钮点击事件
 *
 */
- (IBAction)saveBtnOnClick:(UIButton *)sender;

@end

@implementation JHEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置姓名文本输入框
    self.nameField.text = _contatc.name;
    // 设置电话文本输入框
    self.phoneField.text = _contatc.phoneNumber;
    
    // 1.拿到通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 2.注册监听
    // 注意点: 一定要写上通知的发布者
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange
{
    self.saveBtn.enabled = (self.nameField.text.length > 0  &&
                            self.phoneField.text.length > 0);
}

/*
 因为控制器的view是懒加载的, 用到的时候再加载
 而设置模型数据是在控制器跳转之前, 此时没有用到控制器的view,
 所以控制器的view还没有创建, 它的子控件也没有创建
 */
/*
 - (void)setContatc:(NJContatc *)contatc
 {
 _contatc = contatc;
 
 NSLog(@"%p - %p", self.nameField, self.phoneField);
 NSLog(@"%@ - %@", self.nameField, self.phoneField);
 // 设置姓名文本输入框
 self.nameField.text = _contatc.name;
 // 设置电话文本输入框
 self.phoneField.text = _contatc.phoneNumber;
 }
 */

- (IBAction)editBtnOnClick:(UIBarButtonItem *)sender
{
    if (self.nameField.enabled) {
        // 1.让文本输入框不可以交互
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        // 2.隐藏保存按钮
        self.saveBtn.hidden = YES;
        // 3.让键盘消失
        [self.view endEditing:YES];
        // 4.修改按钮标题
        sender.title = @"编辑";
        // 5.还原数据
        // 设置姓名文本输入框
        self.nameField.text = _contatc.name;
        // 设置电话文本输入框
        self.phoneField.text = _contatc.phoneNumber;
    } else {
        // 当前是不可以编辑状态
        // 1.让文本输入框可以交互
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        // 2.显示保存按钮
        self.saveBtn.hidden = NO;
        // 3.让电话文本输入框召唤出键盘
        [self.phoneField becomeFirstResponder];
        // 4.修改按钮标题
        sender.title = @"取消";
    }
}

- (IBAction)saveBtnOnClick:(UIButton *)sender {
    
    // 1.移除栈顶控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    // 2.修改模型数据
    //NSLog(@"编辑界面 %p" , self.contatc);
    self.contatc.name = self.nameField.text;
    self.contatc.phoneNumber = self.phoneField.text;
    // 3.通知代理
    if ([self.delegate respondsToSelector:@selector(editViewControllerDidClickSavBtn:contatc:)]) {
        [self.delegate editViewControllerDidClickSavBtn:self contatc:self.contatc];
    }
    
}


@end
