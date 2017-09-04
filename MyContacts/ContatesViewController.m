

#import "ContatesViewController.h"
#import "AddViewController.h"
#import "NJContatc.h"
#import "EditViewController.h"
#import "TableViewCell.h"

#define NJContactsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.arc"]

@interface JHContatesViewController ()<UIActionSheetDelegate,JHAddViewControllerDelegate,JHEditViewControllerDelegate>

/** 点击注销按钮 */
- (IBAction)logout:(UIBarButtonItem *)sender;

/**
 *  保存所有用户数据
 */
@property (nonatomic, strong) NSMutableArray *contatcs;

@end

@implementation JHContatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 给当前控制器的当前行控制器添加一个按钮
    UIBarButtonItem *addBtn = self.navigationItem.rightBarButtonItem;
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editBtnClick)];
    self.navigationItem.rightBarButtonItems = @[editBtn,addBtn];
}

- (void)editBtnClick
{
    //    NSLog(@"editBtnClick");
    // 开启tableview的编辑模式
    //    self.tableView.editing = !self.tableView.editing;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}



- (IBAction)logout:(UIBarButtonItem *)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil,nil];
    
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 != buttonIndex) {
        return;
    }
    
    // 移除栈顶控制器
    [self.navigationController popViewControllerAnimated:YES];
}

// 无论是手动类型的segue还是自动类型的segue, 在跳转之前都会执行该方法
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 0.判断目标控制器是添加还是编辑
    // 1.取出目标控制器
    UIViewController *vc = (JHAddViewController *)segue.destinationViewController;
    if ([vc isKindOfClass:[JHAddViewController class]]) {
        JHAddViewController *addVc = (JHAddViewController *) vc;
        // 2.设置代理
        addVc.delegate = self;
    }else if ([vc isKindOfClass:[JHEditViewController class]])
    {
        // 传递数据
        JHEditViewController *editVc = (JHEditViewController *)vc;
        // 通过tableview获取被点击的行号
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        // 取出被点击行的模型
        NJContatc *c = self.contatcs[path.row];
        //NSLog(@"联系人列表 %p" , c);
        // 赋值模型
        editVc.contatc = c;
        // 设置代理
        editVc.delegate = self;
    }
}

#pragma mark - JHEditViewControllerDelegate
- (void)editViewControllerDidClickSavBtn:(JHEditViewController *)editViewController contatc:(NJContatc *)cpmtatc
{
    // 1.修改模型
    //    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    //    self.contatcs[path.row] = cpmtatc;
    
    [NSKeyedArchiver archiveRootObject:self.contatcs toFile:NJContactsPath];
    
    
    // 2.刷新表格
    [self.tableView reloadData];
}

#pragma mark - JHAddViewControllerDelegate
-(void)addViewControllerDidAddBtn:(JHAddViewController *)addViewController contatc:(NJContatc *)contatc
{
    // 1.保存数据到数组中
    [self.contatcs addObject:contatc];
    
    // 在这个地方保存用户添加的所有的联系人信息
    [NSKeyedArchiver archiveRootObject:self.contatcs toFile:NJContactsPath];
    
    
    // 2.刷新表格
    [self.tableView reloadData];
}

// 只在在tableview的编辑模式下才有添加

// 只要实现该方法, 手指在cell上面滑动的时候就自动实现了删除按钮
// commitEditingStyle: 传入提交的编辑操作(删除/添加)
// forRowAtIndexPath: 当前正在编辑的行
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        // 1.修改数据
        [self.contatcs removeObjectAtIndex:indexPath.row];
        // 2.刷新表格
        // reloadData会重新调用数据的所有方法,刷新所有的行
        //    [self.tableView reloadData];
        
        // 该方法用于删除tableview上指定行的cell
        // 注意:使用该方法的时候,模型中删除的数据的条数必须和deleteRowsAtIndexPaths方法中删除的条数一致,否则会报错
        // 简而言之,就删除的数据必须和删除的cell保持一致
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        // 3.更新保存的文件
        [NSKeyedArchiver archiveRootObject:self.contatcs toFile:NJContactsPath];
    }else if (UITableViewCellEditingStyleInsert == editingStyle)
    {
        // 添加一条数据
        //        NSLog(@"添加一条数据");
        
        // 1.修改数据
        NJContatc *c = [[NJContatc alloc] init];
        c.name = @"xff";
        c.phoneNumber = @"123456";
        
        //        [self.contatcs addObject:c];
        [self.contatcs insertObject:c atIndex:indexPath.row + 1];
        
        //        NJContatc *c1 = [[NJContatc alloc] init];
        //        c1.name = @"xzz";
        //        c1.phoneNumber = @"123456";
        //        [self.contatcs insertObject:c1 atIndex:indexPath.row + 2];
        
        // 2.刷新表格
        //        [self.tableView reloadData];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        // 注意点:数组中插入的条数必须和tableview界面上插入的cell条一致
        // 否则程序会报错
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

// 用于告诉系统开启的编辑模式是什么模式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        return UITableViewCellEditingStyleInsert;
    }else
    {
        return UITableViewCellEditingStyleDelete;
    }
}

-(NSMutableArray *)contatcs
{
    // 从文件中读取数组
    // 如果第一次启动没有文件,就创建一个空的数组用于保存数据
    if (_contatcs == nil) {
        _contatcs = [NSKeyedUnarchiver unarchiveObjectWithFile:NJContactsPath];
        if (_contatcs == nil) {
            _contatcs = [NSMutableArray array];
        }
    }
    
    return _contatcs;
}

#pragma mark - 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contatcs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    // 1.创建cell
    JHContatcCell *cell = [JHContatcCell cellWithTableView:tableView];
    // 2.设置模型
    // 设置数据
    NJContatc *c = self.contatcs[indexPath.row];
    cell.contatc = c;
    
    return cell;
}

@end
