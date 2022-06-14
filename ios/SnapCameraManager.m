#import "SnapCamera-Bridging-Header.h"
#import <Foundation/Foundation.h>

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(SnapCameraManager, RCTViewManager)

RCT_EXTERN_METHOD(applyLens:(NSString)lensId
                  withBase64:(NSString)base64
                  withHeight:(nonnull NSNumber)height
                  withWidth:(nonnull NSNumber)width

                  withWatermarkVisible:(BOOL)watermarkVisible
                  withWatermarkAlpha:(nonnull NSNumber)watermarkAlpha

                  withWatermarkBase64:(NSString)watermarkBase64
                  withWatermarkHeight:(nonnull NSNumber)watermarkHeight
                  withWatermarkWidth:(nonnull NSNumber)watermarkWidth

                  withWatermarkTop:(nonnull NSNumber)watermarkTop
                  withWatermarkRight:(nonnull NSNumber)watermarkRight
                  withWatermarkBottom:(nonnull NSNumber)watermarkBottom
                  withWatermarkLeft:(nonnull NSNumber)watermarkLeft)

RCT_EXTERN_METHOD(startRecording)
RCT_EXTERN_METHOD(finishRecording:(RCTResponseSenderBlock)completion)
RCT_EXTERN_METHOD(takePhoto:(RCTResponseSenderBlock)completion)
RCT_EXTERN_METHOD(getLenses:(RCTResponseSenderBlock)completion)

@end
