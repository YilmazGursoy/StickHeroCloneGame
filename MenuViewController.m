//
//  MenuViewController.m
//  StickHeroCloneGame
//
//  Created by MostWanted on 14/11/14.
//  Copyright (c) 2014 yilmaz gursoy. All rights reserved.
//

#import "MenuViewController.h"
#import <GameKit/GameKit.h>
@interface MenuViewController ()<GKLeaderboardViewControllerDelegate>
@property (strong, nonatomic) UIButton *PlayButton;
@property (strong, nonatomic) NSTimer *buttonTimer;
@property (nonatomic) int UstDeger;
@property (nonatomic) int AltDeger;
@property (strong, nonatomic) IBOutlet UIImageView *karakter;
@property (strong, nonatomic) IBOutlet UIImageView *blok;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    //Button atamasi
    self.gameCenterImageView=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width*0.133, self.view.frame.size.height-self.view.frame.size.height*0.0749, self.view.frame.size.width*0.133, self.view.frame.size.height*0.0749)];

    [self.gameCenterImageView setImage:[UIImage imageNamed:@"abc.png"] forState:UIControlStateNormal];
    [self.gameCenterImageView addTarget:self action:@selector(showLeaderboard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.gameCenterImageView];
    
    self.karakter=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.459, self.view.frame.size.height*0.654, self.view.frame.size.width*0.084, self.view.frame.size.height*0.088)];

    [self.view addSubview:self.karakter];
    
    
    self.blok=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.409, self.view.frame.size.height*0.739, self.view.frame.size.width*0.181, self.view.frame.size.height*0.285)];
    self.blok.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.blok];
    
    self.GameNamelabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.137, self.view.frame.size.height*0.061, self.view.frame.size.width*0.725, self.view.frame.size.height*0.454)];
    self.GameNamelabel.textColor=[UIColor blackColor];
    self.GameNamelabel.text=@"Stick Hero";
    [self.GameNamelabel setFont:[UIFont systemFontOfSize:60]];
    self.GameNamelabel.textAlignment=NSTextAlignmentCenter;
    self.GameNamelabel.numberOfLines=0;
    
    [self.view addSubview:self.GameNamelabel];
    


    
    
    
    [super viewDidLoad];

    [[GKLocalPlayer localPlayer]authenticateWithCompletionHandler:^(NSError *error) {
        if(!error){
            NSLog(@"authentication Succeded");
        }
        else{
            NSLog(@"False");
        }
    }];
    
    self.navigationItem.hidesBackButton=YES;
    // Do any additional setup after loading the view.

    self.PlayButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-(self.view.frame.size.width*0.2), self.view.center.y-(self.view.frame.size.width*0.2),self.view.frame.size.width*0.4,self.view.frame.size.width*0.4)];
    self.PlayButton.backgroundColor=[UIColor redColor];
    [self.PlayButton setTitle:@"PLAY" forState:UIControlStateNormal];
    [self.PlayButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.PlayButton.layer.shadowColor=[UIColor blackColor].CGColor;
    self.PlayButton.layer.shadowOpacity=3;
    [self.PlayButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:36.0]];
    self.PlayButton.highlighted=YES;
    [self buttonSetFrame];
    self.buttonTimer=[NSTimer scheduledTimerWithTimeInterval:5.1 target:self selector:@selector(buttonSetFrame) userInfo:nil repeats:YES];
    
    self.PlayButton.layer.cornerRadius=self.PlayButton.bounds.size.width / 2.0;
    [self.PlayButton bringSubviewToFront:self.view];
    [self.view addSubview:self.PlayButton];
    
    NSArray *imageAnimation=@[[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"],[UIImage imageNamed:@"4.png"],[UIImage imageNamed:@"5.png"]];
    self.karakter.animationImages=imageAnimation;
    self.karakter.animationDuration=1;
    self.karakter.animationRepeatCount=10000;
    [self.karakter startAnimating];
    self.blok.layer.shadowColor=[UIColor blackColor].CGColor;
    self.blok.layer.shadowOpacity=1;
    
    
}
-(void)action:(UIButton*)button{
    [self performSegueWithIdentifier:@"Segue" sender:self];
    NSLog(@"Heyy");
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonSetFrame{
    static int i=0;
    if(i%2==0){
        CGPoint newLeftCenter = CGPointMake( self.PlayButton.center.x, self.PlayButton.center.y-10);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:4.0f];
        self.PlayButton.center = newLeftCenter;
        [UIView commitAnimations];
    }
    else{
        CGPoint newLeftCenter = CGPointMake( self.PlayButton.center.x, self.PlayButton.center.y+10);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:4.0f];
        self.PlayButton.center = newLeftCenter;
        [UIView commitAnimations];
        
    }
    i++;
    
}
- (IBAction)showLeaderboard:(UIButton *)sender {
    GKLeaderboardViewController *abc=[[GKLeaderboardViewController alloc]init];
    if(abc!=nil)
    {
        abc.leaderboardDelegate=self;
        [self presentModalViewController:abc animated:YES];
    }
}
-(void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Cikti");
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
