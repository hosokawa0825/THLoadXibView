//
//  THLoadXibView.m
//
//  Created by hosokawa on 13/05/11.
//

#import "THLoadXibView.h"

@interface THLoadXibView ()
@end

@implementation THLoadXibView
// XIBのキャッシュ
static NSCache *cache;
+ (void)initialize {
    cache = [[NSCache alloc] init];
}

+ (void)setCountLimit:(NSUInteger)limit {
    [cache setCountLimit:limit];
}

// initメソッドでインスタンスを生成した場合はCustomView.xibの設定を使う。
- (id)init {
    NSCoder *coder = [self createCoder];
    return [self initWithCoder:coder];
}

// initWithFrameメソッドでインスタンスを生成した場合はCustomView.xibの設定のframeのみ上書きする。
- (id)initWithFrame:(CGRect)frame {
    self = [self init];
    if (self) {
        self.frame = frame;
        [self initialize];
    }
    return self;
}

// initWithCoderメソッドでインスタンスを生成した場合は
// 最も上の階層のView(top view)の設定のみCustomViewが埋め込まれたXIB(親XIB)内での設定を使う。
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    // initメソッドから呼ばれた場合、aDecoderにsubViewが既に含まれているため一旦削除する
    while (self.subviews.count) {
        [self.subviews[0] removeFromSuperview];
    }
    if (self) {
        CGRect frame = self.frame;
        UIView *topView = [self createViewFromXib];
        // Subviewの位置がずれるのを防ぐためtop viewとframeを合わせてからsubviewを移す。
        // top viewは親XIBで生成されたものを使用するため、CustomView.xibから生成したものは捨てる。
        self.frame = topView.frame;
        for (UIView *view in topView.subviews) {
            [self addSubview:view];
        }
        self.frame = frame;
        [self initialize];
    }
    return self;
}

- (NSCoder *)createCoder {
    // 高速化のためにキャッシュを使用する。
    if ([cache objectForKey:self.nibName]) {
        return [cache objectForKey:self.nibName];
    } else {
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [[self createViewFromXib] encodeWithCoder:archiver];
        [archiver finishEncoding];
        NSCoder *coder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        // XIBをロードする回数を減らすため、NSCoderをキャッシュする
        [cache setObject:coder forKey:self.nibName];
        return coder;
    }
}

- (UIView *)createViewFromXib {
    UINib *nib = [UINib nibWithNibName:self.nibName bundle:[NSBundle mainBundle]];
    NSArray *topViews = [nib instantiateWithOwner:self options:nil];
    if (topViews.count == 1) {
        return topViews[0];
    } else {
        [NSException raise:@"Invalid xib file." format:@"%@.xib has no top level view or 2 and over. Xib file must have one top level view.", self.nibName];
    }
}

// protected
- (NSString *)nibName {
    // デフォルトではクラス名と同名のXIBファイルが読み込まれる。別のXIBを読み込ませたい場合はoverrideすること。
    return NSStringFromClass([self class]);
};

// protected
// サブクラスで初期化処理を実行したい場合にoverrideする。
// XIBからインスタンスを作った場合も、コードからインスタンスを作った場合も呼ばれる。
- (void)initialize {}
@end