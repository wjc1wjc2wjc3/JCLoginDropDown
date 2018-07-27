//
//  JCLoginDropDown.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "JCLoginDropDown.h"

#define RGB(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:1.0]

@implementation JCLoginDropDown {
    NSInteger rowWidth;
    NSInteger rowHeight;
    NSString *path;
    NSString *deleteAccount;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height * 3)];
    [self setBackgroundColor:[UIColor clearColor]];
    
    _utv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _utv.delegate = self;
    _utv.dataSource = self;
    _utv.backgroundColor = [UIColor whiteColor];
    _utv.layer.masksToBounds = YES;
    _utv.layer.borderColor = RGB(220, 220, 220).CGColor;
    _utv.layer.borderWidth = 1.0;
    _utv.separatorColor = [UIColor grayColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_utv setTableFooterView:view];
    
    rowHeight = frame.size.height;
    rowWidth = frame.size.width;
    
    self.hidden = YES;
    [self addSubview:_utv];
    
    path = [[NSBundle mainBundle] pathForResource:@"libSDKCall" ofType:@"bundle"];
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [self customCellWithOutXib:tableView withIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *account = [_tableArray objectAtIndex:[indexPath row]];
    [self.delegate clickRow:account];
    self.hidden = YES;
    //    [self.utv selectRowAtIndexPath:0 animated:NO scrollPosition:UITableViewScrollPositionTop];
}

-(UITableViewCell *)customCellWithOutXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    //定义标识符
    static NSString *customCellIndentifier = @"CustomCellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIndentifier];
    
    //定义新的cell
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellIndentifier];
        
        //账号
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, rowWidth, rowHeight)];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.tag = 1;//设置tag，以便后面的定位
        nameLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:nameLabel];
        
        
        //删除按钮
        NSInteger buttonSize = 15;
        NSInteger buttonPadding = (rowHeight - buttonSize)/2;
        
        CGRect imageRect = CGRectMake(rowWidth - buttonSize - buttonPadding, buttonPadding, buttonSize, buttonSize);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = 2;
        [cell.contentView addSubview:imageView];
    }
    //获得行数
    NSUInteger row = [indexPath row];
    
    //取得相应行数的数据
    NSString *account = [_tableArray objectAtIndex:row];
    
    //设置图片
    UIImageView *imageV = (UIImageView *)[cell.contentView viewWithTag:2];
    imageV.image = [UIImage imageNamed:@"dropdownclose"];
    
    [imageV setUserInteractionEnabled:YES];
    imageV.tag = row;
    
    UITapGestureRecognizer *imageGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteAccount:)];
    [imageV addGestureRecognizer:imageGesture];
    
    //设置姓名
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:1];
    name.text = account;
    
    return cell;
}

-(void)deleteAccount:(id)sender{
    UITapGestureRecognizer * tap = (UITapGestureRecognizer *)sender;
    UIImageView *imv = (UIImageView *)tap.view;
    deleteAccount = [_tableArray objectAtIndex:imv.tag];
    [self.delegate deleteRow:self->deleteAccount];
}


@end
