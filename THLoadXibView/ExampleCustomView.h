//
//  ExampleCustomView
//
//  Created by hosokawa on 13/05/13.
//

#import <Foundation/Foundation.h>
#import "THLoadXibView.h"

@interface ExampleCustomView : THLoadXibView
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

- (id)initFromAnotherXib;
@end