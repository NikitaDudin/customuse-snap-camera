import SwiftUI

import SCSDKCameraKit
import SCSDKCreativeKit
import SCSDKCameraKitReferenceUI
import SCSDKCameraKitReferenceSwiftUI

class SnapCameraProps : ObservableObject {
  @Published var groupId: String = "f55a9941-7a60-4bae-a1b8-459b0c877d47"
  @Published var lensId: String = ""
  
  @Published var textureString: String = ""
  @Published var textureHeight: Int = 0
  @Published var textureWidth: Int = 0

  // Examples
  @Published var count: Int = 0
  @Published var onCountChange: RCTDirectEventBlock = { _ in }
}

struct SnapCamera : View {
  @ObservedObject var props = SnapCameraProps()
  var cameraController: CameraController
  
  init() {
    self.cameraController = CameraController()
    self.cameraController.groupIDs = [self.props.groupId]
  }
  
  var body: some View {
    CameraView(cameraController: cameraController)
      .onAppear(perform: applyLens)
  }
  
  private func applyLens() {
    let lens = self.cameraController.cameraKit.lenses.repository.lens(
      id: self.props.lensId,
      groupID: self.props.groupId);
    
    if lens != nil {
      let launchDataBuilder = LensLaunchDataBuilder()
      launchDataBuilder.add(string: self.props.textureString, key: "texture_string")
      launchDataBuilder.add(number: self.props.textureHeight as NSNumber, key: "texture_height")
      launchDataBuilder.add(number: self.props.textureWidth as NSNumber, key: "texture_width")
      
      self.cameraController.cameraKit.lenses.processor?.apply(
        lens: lens!,
        launchData: launchDataBuilder.launchData);
    }
  }
}
