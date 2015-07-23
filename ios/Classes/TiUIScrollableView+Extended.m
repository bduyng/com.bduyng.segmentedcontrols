//
//  TiUIScrollableView+Extended.m
//  com.bduyng.segmentedcontrols
//
//  Created by Duy Bao Nguyen on 15/07/2015.
//
//

#import "TiUIScrollableView+Extended.h"

const int CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG = 99;

@implementation TiUIScrollableView (Extended)

-(void)setScrollIndicatorInsets_:(id)args {
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    
    self.scrollview.scrollIndicatorInsets = UIEdgeInsetsMake(
                                                        [TiUtils floatValue:[args objectForKey:@"top"]],
                                                        [TiUtils floatValue:[args objectForKey:@"left"]],
                                                        [TiUtils floatValue:[args objectForKey:@"bottom"]],
                                                        [TiUtils floatValue:[args objectForKey:@"right"]]);
}

-(void)setScrollHorizontalIndicatorImage_:(id)arg {
    UIImageView *horizontalIndicator = self.scrollview.subviews[self.scrollview.subviews.count - 1];
    
    UIImage *image = nil;
    
    if ([arg isKindOfClass:[TiBlob class]]) {
        TiBlob *blob = (TiBlob*)arg;
        image = [blob image];
    }
    else if ([arg isKindOfClass:[UIImage class]]) {
        image = (UIImage*)arg;
    }
    
    horizontalIndicator.image = image;
}

-(void)registerClonedHorizontalScrollIndicator {
    UIImageView *horizontalIndicator = self.scrollview.subviews[self.scrollview.subviews.count - 1];
    NSData *horizontalIndicatorData = [NSKeyedArchiver archivedDataWithRootObject:horizontalIndicator];
    UIView *clonedHorizontalIndicator = (UIView *)[NSKeyedUnarchiver unarchiveObjectWithData:horizontalIndicatorData];
    clonedHorizontalIndicator.tag = CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG;
    clonedHorizontalIndicator.hidden = NO;
    [self.scrollview addSubview:clonedHorizontalIndicator];
}

-(void)setClonedHorizontalScrollIndicatorVisible_:(id)arg {
    if ([TiUtils boolValue:arg] == YES) {
        [self.scrollview flashScrollIndicators];
        [self registerClonedHorizontalScrollIndicator];
    } else {
        if ([self.scrollview viewWithTag:CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG]) {
            UIImageView *clonedHorizontalIndicator = (UIImageView *)[self.scrollview viewWithTag:CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG];
            clonedHorizontalIndicator.hidden = YES;
        }
    }
}

-(void)setScrollHorizontalIndicatorHidden_:(id)arg {
    if ([self.scrollview viewWithTag:CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG]) {
        UIImageView *clonedHorizontalIndicator = (UIImageView *)[self.scrollview viewWithTag:CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG];
        clonedHorizontalIndicator.hidden = [TiUtils boolValue:arg];
    }
}


-(void)setRelocationHorizontalScrollIndicator_:(id)arg {
    if ([self.scrollview viewWithTag:CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG]) {
        UIImageView *clonedHorizontalIndicator = (UIImageView *)[self.scrollview viewWithTag:CLONED_HORIZONTAL_SCROLL_INDICATOR_TAG];
        clonedHorizontalIndicator.hidden = NO;
        float contentOffsetX = [TiUtils intValue:arg] * self.scrollview.bounds.size.width;
        float x = self.scrollview.scrollIndicatorInsets.left + 3;
        if (contentOffsetX != 0) {
            x += contentOffsetX + [TiUtils intValue:arg] * clonedHorizontalIndicator.frame.size.width;
        }
        NSLog(@"%f", x);
        NSLog(@"%f", scrollview.scrollIndicatorInsets.left);
        NSLog(@"%f", scrollview.scrollIndicatorInsets.right);
        NSLog(@"%f", clonedHorizontalIndicator.frame.size.width);
        NSLog(@"%f", clonedHorizontalIndicator.frame.origin.x);
        
        [clonedHorizontalIndicator setFrame:CGRectMake(x, clonedHorizontalIndicator.frame.origin.y, clonedHorizontalIndicator.frame.size.width, clonedHorizontalIndicator.frame.size.height)];
    }
}

-(void)setVerticalScrollIndicatorVisible_:(id)arg {
    [self.scrollview setShowsVerticalScrollIndicator:[TiUtils boolValue:arg]];
}

-(void)setHorizontalScrollIndicatorVisible_:(id)arg {
    [self.scrollview setShowsHorizontalScrollIndicator:[TiUtils boolValue:arg]];
}
@end
