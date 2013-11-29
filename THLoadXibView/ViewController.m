//
//  ViewController.m
//
//  Created by hosokawa on 13/05/13.
//

#import "ViewController.h"
#import "ExampleCustomView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ExampleCustomView *viewFromXib;
@property (strong, nonatomic) ExampleCustomView *viewFromCode;
@end

@implementation ViewController
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
