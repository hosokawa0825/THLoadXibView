//
//  THLoadXibView.m
//
//  Created by hosokawa on 13/05/11.
//

#import "THLoadXibView.h"

@interface THLoadXibView ()
@property (nonatomic) NSString *nibName;
@end

@implementation THLoadXibView
// UITableViewCellのcontentViewとして使用する際など、
// ある程度の数のインスタンスを生成する場合にパフォーマンスが劣化したため
// XIBから生成したNSCoderをキャッシュしている。
static NSCache *coderOfXibCache;
+ (void)initialize {
    coderOfXibCache = [[NSCache alloc] init];
}

+ (void)setXibCacheCountLimit:(NSUInteger)limit {
    [coderOfXibCache setCountLimit:limit];
}

- (instancetype)initWithNibName:(NSString *)nibName {
    self.nibName = nibName;
    self = [self init];
    return self;
}

// initメソッドでインスタンスを生成した場合はCustomView.xibの設定を使う。
- (instancetype)init {
    NSCoder *coder = [self createCoder];
    return [self initWithCoder:coder];
}

// initWithFrameメソッドでインスタンスを生成した場合はCustomView.xibの設定のframeのみ上書きする。
- (instancetype)initWithFrame:(CGRect)frame {
    self = [self init];
    if (self) {
        self.frame = frame;
        [self initialize];
    }
    return self;
}

// initWithCoderメソッドでインスタンスを生成した場合は
// 最も上の階層のView(top view)の設定のみCustomViewが埋め込まれたXIB(親XIB)内での設定を使う。
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
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
    if ([coderOfXibCache objectForKey:self.nibName]) {
        return [coderOfXibCache objectForKey:self.nibName];
    } else {
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [[self createViewFromXib] encodeWithCoder:archiver];
        [archiver finishEncoding];
        NSCoder *coder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        [coderOfXibCache setObject:coder forKey:self.nibName];
        return coder;
    }
}

- (UIView *)createViewFromXib {
    UINib *nib = [UINib nibWithNibName:self.nibName bundle:[NSBundle mainBundle]];
    NSArray *topLevelObjects = [nib instantiateWithOwner:self options:nil];
    UIView *topViewCandidate;
    NSInteger viewCount = 0;
    for (id obj in topLevelObjects) {
        if ([obj isMemberOfClass:[UIView class]]) {
            viewCount++;
            topViewCandidate = obj;
        }
    }
    if (viewCount == 1) {
        return topViewCandidate;
    } else {
        [NSException raise:@"Invalid xib file." format:@"%@.xib has no top level view or 2 and over. Xib file must have one top level view.", self.nibName];
        abort();
    }
}

- (NSString *)nibName {
    // デフォルトではクラス名と同名のXIBファイルが読み込まれる。
    if (_nibName) {
        return _nibName;
    } else {
        return NSStringFromClass([self class]);
    }
}

// protected
// サブクラスで初期化処理を実行したい場合にoverrideする。
// XIBからインスタンスを作った場合も、コードからインスタンスを作った場合も呼ばれる。
- (void)initialize {}
@end