
#ifndef PupilDetect_h
#define PupilDetect_h

#ifdef __cplusplus
//#import <opencv2/core/mat.hpp>
#include "opencv2/core/core.hpp"
//#import <opencv2/imgcodecs.hpp>
//#import <opencv2/imgproc.hpp>
//#import <opencv2/imgcodecs/ios.h>

#endif

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PupilDetectC : NSObject

- (CGPoint) pupilCenter:(UIImage *)eyeImageRGB x:(int)x y:(int)y w:(int)w h:(int)h;
@end

#endif /* PupilDetect_h */
