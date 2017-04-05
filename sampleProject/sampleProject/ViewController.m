//
//  ViewController.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/5/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *text = @"089 5155789 is the number that you have dialed before several days";
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"tel://0895155789"] range:NSMakeRange(0,11)];
    
    self.textView.attributedText = string;
    self.textView.editable = NO;
}

@end
