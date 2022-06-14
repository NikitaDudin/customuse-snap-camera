import SwiftUI

import SCSDKCameraKit
import SCSDKCameraKitReferenceUI
import SCSDKCameraKitReferenceSwiftUI

@available(iOS 14.0, *)
/// A sample implementation of a minimal SwiftUI view for a CameraKit camera experience.
public struct CameraView: View {

    /// A controller which manages the camera and lenses stack on behalf of the view
    private var cameraController: CameraController

    public init(cameraController: CameraController) {
        self.cameraController = cameraController
        cameraController.configure(
            orientation: .portrait,
            textInputContextProvider: nil,
            agreementsPresentationContextProvider: nil,
            completion: nil)
    }

    public var body: some View {
        ZStack {
            PreviewView(cameraKit: cameraController.cameraKit)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 2, perform: cameraController.flipCamera)
                .gesture(
                    MagnificationGesture(minimumScaleDelta: 0)
                        .onChanged(cameraController.zoomExistingLevel(by:))
                        .onEnded { _ in
                            cameraController.finalizeZoom()
                        })
        }
    }

}
