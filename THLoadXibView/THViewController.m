//
//  THViewController.m
//  THLoadXibVIew
//
//  Created by Hosokawa Toru on 2013/12/01.
//  Copyright (c) 2013年 hosokawa. All rights reserved.
//

#import "THViewController.h"
#import "ExampleCustomView.h"

@interface THViewController ()
@property (weak, nonatomic) IBOutlet ExampleCustomView *viewFromXib;
@property (strong, nonatomic) ExampleCustomView *viewFromCode;
@end

@implementation THViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // パフォーマンステスト用
    for (int i = 0; i < 100; i++) {
        self.viewFromCode = [[ExampleCustomView alloc] init];
    }

    self.viewFromCode.testLabel.text = @"viewFromCode";
    [self.view addSubview:self.viewFromCode];
    
    self.viewFromXib.testLabel.text = @"viewFromXib";
}
@end
