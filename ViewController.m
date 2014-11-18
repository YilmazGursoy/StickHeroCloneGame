//
//  ViewController.m
//  StickHeroCloneGame
//
//  Created by MostWanted on 14/11/14.
//  Copyright (c) 2014 yilmaz gursoy. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>
#define RadToDeg(angle) ((M_PI*angle)/180.0)

@interface ViewController ()<UIAlertViewDelegate>
@property (nonatomic) int yAxisDusus;
@property (strong, nonatomic) NSTimer *timerKarakterinDusmesi;
@property (nonatomic) int Score;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.YAxis=0;
    self.Score=0;
    self.scoreLabel.text=[NSString stringWithFormat:@"%i",self.Score];
    self.karakter=[[UIImageView alloc]initWithFrame:CGRectMake(0.08*self.view.frame.size.width,0.674*self.view.frame.size.height,0.072*self.view.frame.size.width,0.074*self.view.frame.size.height)];
    self.karakter.image=[UIImage imageNamed:@"1.png"];
    [self.view addSubview:self.karakter];
    // Do any additional setup after loading the view, typically from a nib.
    self.ilkTaban=[[UIImageView alloc]initWithFrame:CGRectMake(0,0.749*self.view.frame.size.height,0.186*self.view.frame.size.width,self.ilkTaban.frame.size.height+0.599*self.view.frame.size.height)];
    self.ilkTaban.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.ilkTaban];
    int ab=0.173*self.view.frame.size.width;
    int abc=arc4random()%ab;
    self.RandX=abc+self.karakter.frame.size.width;
    int acikDeger=self.view.frame.size.width-self.ilkTaban.frame.size.width;
    int IlkRandYeri=arc4random()%acikDeger;
    self.ilkTaban.layer.shadowColor=[UIColor blackColor].CGColor;
    self.ilkTaban.layer.shadowOpacity=2;


    self.karakter.layer.shadowColor=[UIColor blackColor].CGColor;
    self.karakter.layer.shadowOpacity=0.3;
    IlkRandYeri=IlkRandYeri+self.ilkTaban.frame.size.width;
    self.ikinciTaban=[[UIImageView alloc]initWithFrame:CGRectMake(IlkRandYeri,0.749*self.view.frame.size.height,self.RandX,self.view.frame.size.height)];
    self.ikinciTaban.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.ikinciTaban];
    self.yAxisDusus=self.karakter.frame.origin.y;
    self.ikinciTaban.layer.shadowColor=[UIColor blackColor].CGColor;
    self.ikinciTaban.layer.shadowOpacity=2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
   if(self.ilkTaban.frame.origin.x>self.ikinciTaban.frame.origin.x){
        self.boruImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.ikinciTaban.frame.origin.x+self.ikinciTaban.frame.size.width,0.749*self.view.frame.size.height,0.008*self.view.frame.size.width,0)];
    }
    else{
        self.boruImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.ilkTaban.frame.origin.x+self.ilkTaban.frame.size.width,0.749*self.view.frame.size.height,0.008*self.view.frame.size.width,0)];
    }
    
    self.boruImageView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.boruImageView];
    
    self.boruTimer=[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(BoruBoyuArtirma) userInfo:nil repeats:YES];


}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.boruTimer invalidate];
    self.view.userInteractionEnabled=NO;
    [self.boruImageView.layer setAnchorPoint:CGPointMake(1,1)];
    
    [self.boruImageView.layer setPosition:CGPointMake(self.boruImageView.frame.origin.x+7,0.749*self.view.frame.size.height)];
    [UIImageView animateWithDuration:0.8 animations:^{
        
        [self.boruImageView setTransform:CGAffineTransformMakeRotation(RadToDeg(90))];
    }completion:^(BOOL finished) {
        
        NSArray *imageAnimation=@[[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"],[UIImage imageNamed:@"4.png"],[UIImage imageNamed:@"5.png"]];
        self.karakter.animationImages=imageAnimation;
        self.karakter.animationDuration=1;
        self.karakter.animationRepeatCount=10000;
        [self.karakter startAnimating];
        if(self.ikinciTaban.frame.origin.x>self.ilkTaban.frame.origin.x){
            [self yuruyecegiMesafe:self.ikinciTaban];
        }
        else{
            [self yuruyecegiMesafe:self.ilkTaban];
        }
        
    }];
    
}
-(void)yuruyecegiMesafe:(UIImageView*)ikinciTaban{
    [UIImageView animateWithDuration:1.6 animations:^{
        int StickWidth=self.boruImageView.frame.size.width+self.boruImageView.frame.origin.x;
        
        if((StickWidth>=ikinciTaban.frame.origin.x)&&(StickWidth<=ikinciTaban.frame.origin.x+ikinciTaban.frame.size.width)){

            self.karakter.frame=CGRectMake(ikinciTaban.frame.size.width+ikinciTaban.frame.origin.x-self.karakter.frame.size.width, self.karakter.frame.origin.y, self.karakter.frame.size.width, self.karakter.frame.size.height);
            self.Controller=1;
        }
        else{
            
            self.karakter.frame=CGRectMake(self.boruImageView.frame.size.width+self.karakter.frame.origin.x+self.karakter.frame.size.width/2, self.karakter.frame.origin.y, self.karakter.frame.size.width, self.karakter.frame.size.height);
            self.Controller=0;
        }
        
        //Hareket edecegi yere gitmesi
    }completion:^(BOOL finished) {
        [self ikinciAdim];
        [self.karakter stopAnimating];
        self.karakter.image=[UIImage imageNamed:@"1.png"];
        self.YAxis=0;
        if(self.Controller==0){
            [self.boruImageView.layer setAnchorPoint:CGPointMake(1, 1)];
            [UIImageView animateWithDuration:1 animations:^{
                
                [self KarakterinDusmesiTimer];
                [self.boruImageView setTransform:CGAffineTransformMakeRotation(RadToDeg(180))];
                }completion:^(BOOL finished) {
                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    int standart=(int)[defaults integerForKey:@"key"];
                    if(self.Score>=standart){
                        NSUserDefaults *standartUserDefaults=[NSUserDefaults standardUserDefaults];
                        [standartUserDefaults setInteger:self.Score forKey:@"key"];
                        GKScore *score=[[GKScore alloc]initWithLeaderboardIdentifier:@"Leaderboard"];
                        score.value=(int)[defaults integerForKey:@"key"];
                        [score reportScoreWithCompletionHandler:^(NSError *error) {
                            if(!error){
                                NSLog(@"Submitting Succeded");
                            }
                            else{
                                NSLog(@"Submitting failed");
                            }
                        }];
                    }
                    int highScore=(int)[defaults integerForKey:@"key"];
                    
                    //Submit to Game Center Here

                    
                    
                    
                    
                    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Game Over" message:[NSString stringWithFormat:@"HighScore %i",highScore] delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:nil];
                    alertView.layer.shadowColor=[UIColor blackColor].CGColor;
                    alertView.layer.shadowOpacity=4;
                    [alertView show];
                    
                }];
        }
        else{
            self.Score++;

            self.scoreLabel.text=[NSString stringWithFormat:@"%i",self.Score];
        }
    }];
}
-(void)KarakterinDusmesiTimer{
    self.timerKarakterinDusmesi=[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(KarakterinDusmesi) userInfo:nil repeats:YES];
}
-(void)KarakterinDusmesi{
  
    self.karakter.frame=CGRectMake(self.karakter.frame.origin.x,self.yAxisDusus,self.karakter.frame.size.width, self.karakter.frame.size.height);
    self.yAxisDusus++;
    if(self.yAxisDusus>=self.view.frame.size.height){
        [self.timerKarakterinDusmesi invalidate];
    }
}


#pragma mark-BoyuArtirma


-(void)BoruBoyuArtirma{
    
    self.boruImageView.frame=CGRectMake(self.karakter.frame.origin.x+self.karakter.frame.size.width,0.749*self.view.frame.size.height-self.YAxis,self.boruImageView.frame.size.width,self.YAxis);
    self.YAxis++;
}

#pragma mark-YeniDuvarınGelmesi

-(void)ikinciAdim{
    if(self.Controller==1){
        int KaydirilacakDeger;
        
        if(self.ilkTaban.frame.origin.x>self.ikinciTaban.frame.origin.x){
            
            KaydirilacakDeger=self.ilkTaban.frame.origin.x;
            [self yeniDuvarinHareketi:self.ikinciTaban :self.ilkTaban :KaydirilacakDeger];
            
        }
        
        else{

            KaydirilacakDeger=self.ikinciTaban.frame.origin.x;
            [self yeniDuvarinHareketi:self.ilkTaban :self.ikinciTaban :KaydirilacakDeger];
        }
        
    }
    
}

-(void)yeniDuvarinHareketi:(UIImageView*)ilkTaban :(UIImageView*)ikinciTaban :(int)KaydirilacakDeger{
    [UIImageView animateWithDuration:1 animations:^{
 
        ilkTaban.frame=CGRectMake(-ilkTaban.frame.size.width,ilkTaban.frame.origin.y,ilkTaban.frame.size.width,ilkTaban.frame.size.height);
 
        ikinciTaban.frame=CGRectMake(ikinciTaban.frame.origin.x-KaydirilacakDeger,ikinciTaban.frame.origin.y,ikinciTaban.frame.size.width,ikinciTaban.frame.size.height);
        self.boruImageView.layer.position=CGPointMake(ikinciTaban.frame.origin.x-self.boruImageView.frame.size.width,self.boruImageView.frame.origin.y+5);
 
        self.karakter.layer.frame=CGRectMake(ikinciTaban.frame.origin.x+ikinciTaban.frame.size.width-self.karakter.frame.size.width-5,self.karakter.frame.origin.y,self.karakter.frame.size.width,self.karakter.frame.size.height);

    }completion:^(BOOL finished) {

        self.view.userInteractionEnabled=YES;
        self.boruImageView.frame=CGRectMake(self.karakter.frame.origin.x+self.karakter.frame.size.width,0.749*self.view.frame.size.height,0.008*self.view.frame.size.width,0);

        int RandMax=self.karakter.frame.size.width*3;
        int RandWidth=arc4random()%RandMax+10;

        if(ilkTaban.frame.origin.x>ikinciTaban.frame.origin.x){
            
            [ikinciTaban setFrame:CGRectMake(self.view.frame.size.width, 0.749*self.view.frame.size.height,RandWidth,ikinciTaban.frame.size.height+self.view.frame.size.height)];

            
            [self yandakiDuvarinGelemsi:ikinciTaban ikinici:ilkTaban.frame.size.width];
            
        }
        else{
            
            [ilkTaban setFrame:CGRectMake(self.view.frame.size.width,  0.749*self.view.frame.size.height,RandWidth,ilkTaban.frame.size.height+self.view.frame.size.height)];
            [self yandakiDuvarinGelemsi:ilkTaban ikinici:ikinciTaban.frame.size.width];
            
            }
    }];

    
}
-(void)yandakiDuvarinGelemsi:(UIImageView*)rasgeleDuvar ikinici:(int)ikincininEni{
    
    int aa=self.view.frame.size.width-ikincininEni;
    int RasgeleDeger=arc4random()%aa;
    [UIImageView animateWithDuration:0.2 animations:^{
        if(RasgeleDeger<rasgeleDuvar.frame.size.width){
            rasgeleDuvar.frame=CGRectMake(self.view.frame.size.width-RasgeleDeger*2, 0.749*self.view.frame.size.height,rasgeleDuvar.frame.size.width,self.view.frame.size.height);
    
        }
        else{
            rasgeleDuvar.frame=CGRectMake(self.view.frame.size.width-RasgeleDeger, 0.749*self.view.frame.size.height,rasgeleDuvar.frame.size.width,self.view.frame.size.height);

        }
        
        
    }];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
