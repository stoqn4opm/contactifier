//
//  ViewController.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/5/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "ViewController.h"
#import "NSAttributedString+Contactified.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *text = @"0895155789 is the number that you have dialed before several days, and you have tried this number also 0897949488";
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"tel://0895155789"] range:NSMakeRange(0,10)];
    [string addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"tel://0897949488"] range:NSMakeRange(text.length - 10,10)];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithAttributedString:string];
    
    self.textView.attributedText = [attributedString contactifiedString];
    self.textView.editable = NO;
}

@end
