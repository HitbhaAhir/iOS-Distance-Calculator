//
//  ViewController.m
//  Distance Calculator
//
//  Created by Kevin on 5/1/16.
//  Copyright © 2016 Kevin Skompinski. All rights reserved.
//

#import "ViewController.h"

#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *StartingLocation;

@property (weak, nonatomic) IBOutlet UITextField *EndLocation1;

@property (weak, nonatomic) IBOutlet UITextField *EndLocation2;

@property (weak, nonatomic) IBOutlet UITextField *EndLocation3;

@property (weak, nonatomic) IBOutlet UITextField *EndLocation4;

@property (weak, nonatomic) IBOutlet UILabel *Distance1;

@property (weak, nonatomic) IBOutlet UILabel *Distance2;

@property (weak, nonatomic) IBOutlet UILabel *Distance3;

@property (weak, nonatomic) IBOutlet UILabel *Distance4;

@property (weak, nonatomic) IBOutlet UIButton *UpdateButton;

@end

@implementation ViewController

- (IBAction)ButtonTapped:(id)sender {
    
    self.UpdateButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    
    NSString *start = self.StartingLocation.text;
    NSString *firstD = self.EndLocation1.text;
    NSString *secondD = self.EndLocation2.text;
    NSString *thirdD = self.EndLocation3.text;
    NSString *fourthD = self.EndLocation4.text;
    
    NSArray *dests = @[firstD,secondD,thirdD,fourthD];
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^(NSArray *responses){
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;
        
        NSNull *badResult = [NSNull null];
        
        if(responses[0] != badResult){
            double num = ([responses[0] floatValue]/1000.0);
            NSString *x = [NSString stringWithFormat:@"%.2f km", num];
            strongSelf.Distance1.text = x;
        }
        else{
            strongSelf.Distance1.text = @"Error";
        }
        
        if(responses[1] != badResult){
            double num = ([responses[1] floatValue]/1000.0);
            NSString *x = [NSString stringWithFormat:@"%.2f km", num];
            strongSelf.Distance2.text = x;
        }
        else{
            strongSelf.Distance2.text = @"Error";
        }
        
        if(responses[2] != badResult){
            double num = ([responses[2] floatValue]/1000.0);
            NSString *x = [NSString stringWithFormat:@"%.2f km", num];
            strongSelf.Distance3.text = x;
        }
        else{
            strongSelf.Distance3.text = @"Error";
        }
        
        if(responses[3] != badResult){
            double num = ([responses[3] floatValue]/1000.0);
            NSString *x = [NSString stringWithFormat:@"%.2f km", num];
            strongSelf.Distance4.text = x;
        }
        else{
            strongSelf.Distance4.text = @"Error";
        }
        
        strongSelf.req = nil;
        strongSelf.UpdateButton.enabled = YES;
    };
    
    [self.req start];
    
}

@end
