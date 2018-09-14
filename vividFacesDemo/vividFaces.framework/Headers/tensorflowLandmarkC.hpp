#ifndef tensorflowLandmarkC_h
#define tensorflowLandmarkC_h

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#define d_batch_size 1
//#define IMG_WIDTH 640
//#define IMG_HEIGHT 480
#define WANTED_CHANNEL 3  //wanted channels num
#define landmark_point_num  65
#define bound_point_num  2
#define POINTS_IN_NUM2  130
#define POINTS_OUT_NUM2  130
#define NUMBER_OF_CLASSES 2
#define MORPH_NUM  187

#define max_num_Detections 4

#define input_mean 117.0f
#define input_std 1.0f

@interface TensorflowLandmarkC : NSObject
- (bool)getGraph;
- (bool)saveCkpt;

- (void)setInput_Image:(CVPixelBufferRef)pixelBuffer;
- (void)setTarget_Classes:(float[])TClasses num_detections:(int)num_detections;//num_detections
- (void)setTarget_Boxes:(float[])Boxes num_detections:(int)num_detections;//num_detections*4
- (void)setTarget_Landmark:(float[])landmarks num_detections:(int)num_detections;//num_detections*65*2//(int)pointIndex x:(float)xvalue y:(float)yvalue;
- (void)setUseUserFace:(bool)useUserFace;
- (void)setUserFace:(float[])values;
- (bool) trainLandmark:(float[])result;

- (bool) evalLandmark:(float[])landmark rot_x:(float *)rotxvalue rot_y:(float *)rotyvalue rot_z:(float *)rotzvalue rot3d:(float[])rot3Dvalue;
- (bool) evalMorph:(float *)num_detections landmark:(float[])landmarks scores:(float[])scores classes:(float[])classes boxes:(float[])boxes rot:(float[])rot rot3d:(float[])rot3D morphRet:(float[])morphRet lossMorph:(float *)lossMorph globalStep:(int32_t *)globalStep;
//- (bool) evalMorph:(float[])landmarks rot_x:(float *)rotxvalue rot_y:(float *)rotyvalue rot_z:(float *)rotzvalue rot3d:(float[])rot3Dvalue morphRet:(float[])MorphValue lossMorph:(float *)lossMorph;
- (bool) debug_evalMorph:(float[])landmarks rot_x:(float *)rotxvalue rot_y:(float *)rotyvalue rot_z:(float *)rotzvalue rot3d:(float[])rot3Dvalue morphRet:(float[])MorphValue lossMorph:(float *)lossMorph p2:(float[])p2 p2_input:(float[])p2_input;

@end

#endif /* tensorflowLandmarkC_h */
