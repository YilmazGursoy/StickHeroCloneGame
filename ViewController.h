//
//  ViewController.h
//  StickHeroCloneGame
//
//  Created by MostWanted on 14/11/14.
//  Copyright (c) 2014 yilmaz gursoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) UIImageView *karakter;
@property (strong, nonatomic) NSTimer *boruTimer;
@property (strong, nonatomic) UIImageView *boruImageView;
@property (strong, nonatomic) UIImageView *ilkTaban;
@property (strong, nonatomic) UIImageView *ikinciTaban;
@property (nonatomic) int YAxis;
@property (nonatomic) int RandX;
@property (nonatomic) int Controller;
@end

