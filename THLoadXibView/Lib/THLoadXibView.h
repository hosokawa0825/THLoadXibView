//
//  THLoadXibView.h
//
//  Created by hosokawa on 13/05/11.
//

#import <UIKit/UIKit.h>

/**
* CustomViewクラスのインスタンスをXibからもコードからも生成出来るようにするクラス。
* CustomViewはこのクラスのサブクラスとして作成する。
* CustomViewクラス作成時は以下に注意すること。
* ・XIB内の一番上の階層のViewのクラスはUIViewとする。（CustomViewクラスにしない）
* ・XIB内の一番上の階層にはUIViewを一つだけ置く。
* ・XIBのFile's OwnerをCustomViewクラスにする。
*
*/
@interface THLoadXibView : UIView
// XIBのキャッシュの容量を設定する
+ (void)setXibCacheCountLimit:(NSUInteger)limit;
@end
