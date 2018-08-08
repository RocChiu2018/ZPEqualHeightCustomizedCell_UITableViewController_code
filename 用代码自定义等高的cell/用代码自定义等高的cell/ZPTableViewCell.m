//
//  ZPTableViewCell.m
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPTableViewCell.h"
#import "ZPDeal.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface ZPTableViewCell()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *buyCountLabel;

@end

@implementation ZPTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"deal";
    
    ZPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    /**
     如果不在此方法中撰写创建新的自定义cell的代码的话则应该在视图控制器类中的viewDidLoad方法中撰写相关的注册代码。
     */
    if (cell == nil)
    {
        /**
         一般用initWithStyle方法来对cell进行初始化，而不用init方法来进行初始化，这是因为initWithStyle方法能够绑定特殊标识符而init方法则不能。
         */
        cell = [[ZPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

/**
 用代码的方式创建UITableView控件的自定义cell的时候一般使用如下的方法来创建自定义cell里面的子控件，但是不在此方法中设置子控件的尺寸。
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        CGFloat margin = 10;
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];  //要把子控件加到自定义cell的contentView里面
        [self.iconView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(100);
            make.top.equalTo(self.contentView.top).offset(margin);
            make.left.equalTo(self.contentView.left).offset(margin);
            make.bottom.equalTo(self.contentView.bottom).offset(-margin);
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView);
            make.left.equalTo(self.iconView.right).offset(margin);
            make.right.equalTo(self.contentView).offset(-margin);
        }];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.left);
            make.bottom.equalTo(self.iconView.bottom);
            make.width.equalTo(70);
        }];
        
        self.buyCountLabel = [[UILabel alloc] init];
        self.buyCountLabel.textAlignment = NSTextAlignmentRight;
        self.buyCountLabel.font = [UIFont systemFontOfSize:14];
        self.buyCountLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.buyCountLabel];
        [self.buyCountLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleLabel);
            make.bottom.equalTo(self.priceLabel);
            make.left.equalTo(self.priceLabel.right).offset(margin);
        }];
    }
    
    return self;
}

/**
 在此方法中设置自定义cell里面的子控件的尺寸。
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //iconView
    CGFloat iconX = 10;
    CGFloat iconY = 10;
    CGFloat iconW = 100;
    CGFloat iconH = self.contentView.frame.size.height - 2 * iconY;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //titleLabel
    CGFloat titleX = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat titleY = iconY;
    CGFloat titleW = self.contentView.frame.size.width - titleX - 10;
    CGFloat titleH = 21;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //priceLabel
    CGFloat priceX = titleX;
    CGFloat priceH = 21;
    CGFloat priceY = self.contentView.frame.size.height - 10 - priceH;
    CGFloat priceW = 70;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    //buyCountLabel
    CGFloat buyCountH = 21;
    CGFloat buyCountY = priceY;
    CGFloat buyCountX = CGRectGetMaxX(self.priceLabel.frame) + 10;
    CGFloat buyCountW = self.contentView.frame.size.width  - buyCountX - 10;
    self.buyCountLabel.frame = CGRectMake(buyCountX, buyCountY, buyCountW, buyCountH);
}

/**
 设置数据
 */
-(void)setDeal:(ZPDeal *)deal
{
    _deal = deal;
    
    self.iconView.image = [UIImage imageNamed:deal.icon];
    self.titleLabel.text = deal.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@", deal.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买", deal.buyCount];
}

@end
