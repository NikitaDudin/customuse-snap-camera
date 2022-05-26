#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"
#import "React/RCTComponentEvent.h"
#import "SnapCamera-Bridging-Header.h"

@interface SnapCameraManager : RCTViewManager
@end

@implementation SnapCameraManager

RCT_EXPORT_MODULE(SnapCamera)

RCT_EXPORT_SWIFTUI_PROPERTY(groupId, string, SnapCameraProxy);
RCT_EXPORT_SWIFTUI_PROPERTY(lensId, string, SnapCameraProxy);

RCT_EXPORT_SWIFTUI_PROPERTY(textureString, string, SnapCameraProxy);
RCT_EXPORT_SWIFTUI_PROPERTY(textureHeight, int, SnapCameraProxy);
RCT_EXPORT_SWIFTUI_PROPERTY(textureWidth, int, SnapCameraProxy);

// Examples
RCT_EXPORT_SWIFTUI_PROPERTY(count, int, SnapCameraProxy);
RCT_EXPORT_SWIFTUI_CALLBACK(onCountChange, RCTDirectEventBlock, SnapCameraProxy);

- (UIView *)view {
  SnapCameraProxy *proxy = [[SnapCameraProxy alloc] init];
  UIView *view = [proxy view];
  NSMutableDictionary *storage = [SnapCameraProxy storage];
  storage[[NSValue valueWithNonretainedObject:view]] = proxy;
  return view;
}

@end
