//
//  JCLoginDropDown.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCLoginDropDownDelegate
- (void)clickRow:(NSString *)account;
- (void)deleteRow:(NSString *)account;
@end

@interface JCLoginDropDown : UIView<UITableViewDelegate , UITableViewDataSource>

@property UITableView *utv;//tableView

@property NSMutableArray *tableArray;//下拉列表数据

@property id<JCLoginDropDownDelegate> delegate;

@end
