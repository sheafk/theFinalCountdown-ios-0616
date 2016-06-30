//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()

@property NSDate *startDate;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic) NSTimer *timer;

@end

@implementation FISViewController

//int timeTick = 9;
//NSTimer *timer;

int afterRemainder;
int remainderNum;
NSTimeInterval countDownInterval;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Remove Autoconstraints in Autolayout
    [self.view removeConstraints:self.view.constraints];
    self.timerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.timerView removeConstraints:self.timerView.constraints];
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self.datePicker removeConstraints:self.datePicker.constraints];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.startButton removeConstraints:self.pauseButton.constraints];
    self.pauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pauseButton removeConstraints:self.pauseButton.constraints];
    self.labelTime.translatesAutoresizingMaskIntoConstraints = NO;
    [self.labelTime removeConstraints:self.pauseButton.constraints];
    
    //Set TimerView in Autolayout
    [self.timerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active=YES;
    [self.timerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active=YES;
    [self.timerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active=YES;
    [self.timerView.topAnchor constraintEqualToAnchor:self.view.centerYAnchor].active=YES;

    //Set Datepicker in Autolayout
    [self.datePicker.topAnchor constraintEqualToAnchor:self.view.topAnchor].active=YES;
    [self.datePicker.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active=YES;
    [self.datePicker.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [self.datePicker.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor].active=YES;
    
    //Set Time Label constraints in Autolayout
    [self.labelTime.topAnchor constraintEqualToAnchor:self.view.topAnchor].active=YES;
    [self.labelTime.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [self.labelTime.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active=YES;
    [self.labelTime.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor].active=YES;

    //Set Start and Pause Buttons in Autolayout
    [self.startButton.bottomAnchor constraintEqualToAnchor:self.timerView.centerYAnchor].active=YES;
    [self.startButton.rightAnchor constraintEqualToAnchor:self.timerView.centerXAnchor constant:-30].active=YES;
    
    [self.pauseButton.bottomAnchor constraintEqualToAnchor:self.timerView.centerYAnchor].active=YES;
    [self.pauseButton.leftAnchor constraintEqualToAnchor:self.timerView.centerXAnchor constant:30].active=YES;
    
    [self.cancelButton.bottomAnchor constraintEqualToAnchor:self.timerView.centerYAnchor].active=YES;
    [self.cancelButton.rightAnchor constraintEqualToAnchor:self.timerView.centerXAnchor constant:-30].active=YES;
    
    //The timer should be hidden in initial view
    self.labelTime.hidden = YES;
    self.cancelButton.hidden = YES;
    self.labelTime.adjustsFontSizeToFitWidth = YES;
    self.labelTime.text = [[NSString alloc] initWithFormat:@"00:00:00"];

}

//Actions after time is selected
- (IBAction)dateSelect:(UIDatePicker *)sender {

    
}

//Actions after start is tapped
- (IBAction)startTimer:(id)sender {
    self.datePicker.hidden = YES;
    self.cancelButton.hidden = NO;
    self.labelTime.hidden = NO;
    self.startButton.hidden = YES;
    //self.pauseButton.titleLabel.textColor = [UIColor blackColor]; //If the timer is running, it will set the pause button to black.
    
    
    countDownInterval = (NSTimeInterval)self.datePicker.countDownDuration;
    remainderNum = countDownInterval;
    afterRemainder = countDownInterval - remainderNum%60;
    
    //[timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];

}


-(void)updateCountDown {
    
    if (afterRemainder == 0) {
        [self.timer invalidate];
        self.labelTime.text = [[NSString alloc] initWithFormat:@"00:00:00"];
        //[self viewDidLoad];
    }
    
    else {
        
        afterRemainder--;
        
        int hours = (int)(afterRemainder/(60*60));
        int mins = (int)(((int)afterRemainder/60) - (hours * 60));
        int secs = (int)(((int)afterRemainder - (60 * mins) - (60 * hours *60)));
        NSString *showText = [[NSString alloc] initWithFormat:@"%02u:%02u:%02u", hours, mins, secs];
        
        self.labelTime.text = showText;
    }
}

//Actions after pause button is tapped
- (IBAction)pauseButton:(UIButton *)sender {
     [self.timer invalidate];
}


- (IBAction)cancelTimer:(UIButton *)sender {
    
    [self.timer invalidate];
   // [self.datePicker setDate:00:00 animated:TRUE];
    self.datePicker.hidden = NO;
    self.labelTime.hidden = YES;
    self.cancelButton.hidden = YES;
    self.startButton.hidden = NO;
    
    afterRemainder = 0;
    remainderNum = 0;
    countDownInterval =0;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];

}

- (void)viewWillAppear:(BOOL)animated
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
