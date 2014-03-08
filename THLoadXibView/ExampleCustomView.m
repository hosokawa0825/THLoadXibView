//
//  ExampleCustomView
//
//  Created by hosokawa on 13/05/13.
//

#import "ExampleCustomView.h"

@interface ExampleCustomView ()
@property(nonatomic, strong) NSString *customNibName;
@end

@implementation ExampleCustomView
// クラス名と異なるファイル名のXIBファイルを読み込む場合はこのメソッドを呼び出す。
// 但し、XIBの中にExampleCustomViewを埋め込んだ場合はExampleCustomView.xibがロードされる。
// 一貫性がなく分かりづらいためあまりおすすめしない。ViewクラスとXIBファイルは1対1にすべき。
- (id)initFromAnotherXib {
    self = [super initWithNibName:@"ExampleCustomViewAnother"];
    return self;
}

- (void)initialize {
    // 初期化コードを実装する
}
@end