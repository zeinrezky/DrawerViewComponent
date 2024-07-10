//
//  DrawerView.h
//  DrawingComponent
//
//  Created by zein rezky chandra on 10/07/24.
//

#import <UIKit/UIKit.h>

@interface DrawerView : UIView

@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) BOOL isSwiping;
@property (nonatomic, strong) UIImage *image;

@end
